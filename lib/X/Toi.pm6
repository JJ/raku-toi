unit module X::Toi;

#| Exception where a data accessor finds no file
class NoFile is Exception {
    has Str $.file-name;
    method message() { "File $!file-name does not exist" }
}
