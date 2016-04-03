use strict;
use Test::More 0.98;
use Carp 'croak';
use Time::Piece;
use Path::Tiny;
use Carvo::Restorer;

my $datetime = localtime->datetime(T => '-');
$datetime =~ s/(\d{4}-\d{2}-\d{2}-\d{2}):(\d{2}):(\d{2})/$1-$2-$3/;

my $attr = {
    'num' => 2,
    'fmt' => 'yml',
    'selected_revert' => $datetime,
    'card_name' => 'daily',
};
my $data = {
    'words' => [qw/abandoned abominable abortion/],
    'fail' => [qw/abroad acclaim accomplish/],
};

my $dir_name = 'src/save';
my $save_path = "$dir_name/$datetime";

subtest "restorer" => sub {

    Restorer::save($attr, $data);
    my ($got_attr, $got_data) = Restorer::rs($attr, $data);

    path($save_path)->remove_tree;

    is_deeply $got_attr, $attr, 'save_attr';
    is_deeply $got_data, $data, 'save_data';
};

subtest "read-only" => sub {

    my $got_save = Restorer::ro;

    my $expect_save;
    my $files = path($dir_name)->iterator;
    while (my $saved_datetime = $files->()) {
        if ($saved_datetime =~ /(\d[\d-]+\d)$/) {
            push @$expect_save, $1;
        }
    }

    is_deeply $got_save->{saved_datetime}, $expect_save, 'save_read_only';

};

done_testing;
