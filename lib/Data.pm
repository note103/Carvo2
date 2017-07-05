package Data {
    use strict;
    use warnings;
    use feature 'say';

    sub init {
        my %attr = (
            ans_num    => '',
            fail_sw    => 'off',
            lesson_dir => 'src/lesson',
            sound_dir  => 'src/sound',
            log_record => 'on',
            miss       => 0,
            num        => 0,
            num_buffer => 0,
            num_normal => 0,
            point      => 0,
            quit       => '',
            sound_able => 1,
            total      => 0,
            voice      => 'say',
            voice_able => 1,
            voice_ch   => 'on',
        );
        return \%attr;
    }
}

1;
