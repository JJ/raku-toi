#!/usr/bin/env raku

use Telegram; # remember to zef install Telegram
use Toi;
use Toi::Data::YAML;


my $bot = Telegram::Bot.new(%*ENV<TOI_BOT_TOKEN>);
my $data = Toi::Data::YAML.new;
my $toi = Toi.new: :$data;

$bot.start(1);

react {
    whenever $bot.messagesTap -> $msg {
        $msg.text ~~ /\/$<command> = (\w+) \h* $<args> = (.*)/;
        say "$msg $<command>";
        given $<command> {
            when "toi" {
                my @args = $<args>.words.map: +*;
                $toi.check-in($msg.sender.username, |@args);
                $bot.sendMessage( $msg.chat.id, "Registrado $<args> para "
                                    ~ $msg.sender.username );
            }
            when "about" {
                $bot.sendMessage($msg.chat.id, q:to/EOM/);
To check in, use /toi coord-x coord-y
The coord-x and coord-y in class will follow the same convention
EOM
            }
        }
    }
    whenever signal(SIGINT) {
        $bot.stop;
        exit;
    }
}
