package DataDownloader;

use strict;
use warnings;
use Net::FTP;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(ftp_connect make_link download checkdir date_string);

#connect to server
sub ftp_connect(){
my ($server,$dir,$user,$password) = @_;

my $ftp = Net::FTP->new($server, Passive => 1)
or die "Cannot connect to $server: $@";

$ftp->login($user,$password)
or die "Cannot login ", $ftp->message;

$ftp->cwd($dir);

return $ftp;
}

#create symbolic links to the latest file
sub make_link(){
	my ($dir, $link) = @_;
	unlink $link;
	symlink ($dir, "$link") or die "can't create $link";
}

#download and unzip a file, unless the output directory already exists
sub download(){
my ($ftp,$dir, $file) = @_;
	
	#if checkdir creates a new directory, download the file
	if(&checkdir($dir) == 1){
  		print STDERR "getting $file to $dir\n";

  		$ftp->binary();
  		$ftp->get($file, "$dir/$file")or die "get failed ", $ftp->message;
  
  		print"gzip -dr $dir\n";

  		if ((system "gzip -dr $dir") != 0) {
  		  die qq|system "gzip -dr $dir" failed: $?\n|;
  		}
		return 1;
	}
	else{
	    warn " current version up to date - skipping download\n";
		return 0;
	}
}

#check if a directory exists, create it if it doesn't
sub checkdir(){
	my $dir = shift;
	if (!(-d $dir)) {
	    print STDERR "creating directory: $dir\n";
	    mkdir $dir	
	        or die "failed to create directory $dir";
		return 1;	
	}else{
		print STDERR "$dir exists\n";
		return 0;
	}
}
#get the date stamp from a file to be downloaded
sub date_string(){
	my ($ftp,$file) = @_;

	my $gene_date_stamp = $ftp->mdtm($file);
	my ($second, $minute, $hour, $day, $month, $year, $weekday, $dayofyear, $isdst) = localtime($gene_date_stamp);

	$month += 1;
	$year -= 100;
	$year += 2000;

	print "$file was created on $day $month $year\n";
	my $date_string = sprintf "%02s-%02s-%02s", $year, $month, $day;

	return $date_string;
}

1;
