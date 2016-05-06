function [x,ascii] = file2bin(file)

% 'file' should be the filename of a simple text file,
%      including extension, e.g. foo.txt

% read file contents. Every call to fgets retireves one line of text.
% the loop concatenates them, making a variable s were every row is a text
% string correspodning to one line of thetext.
s=[];
fid=fopen(file,'r');
while (~feof(fid));
  s=[s fgets(fid)];
end

as  = double(lower(char(s))); % convert to lower case, then to numeric ASCII code

% find indices that have spaces, line feeds, and so forth, and those that
% have regular characters
lindex = find((as>96) & (as<123));  % lower case letters
spindex = find(as==32);
lfindex = find(as==10);
rindex  = find(as==13);
cindex  = find(as==44);
pindex  = find(as==46);
qindex  = find(as==39);

% recode the sequence so everyting fits in the range 0:31 and therefore
% into 5 bits.  Anything that isn't space, comma, period, apostropher,
% line feed, return, or 'a' through 'z' is left as a NaN.
asciiseq = NaN*ones(1,length(as));
asciiseq(lindex)  = as(lindex)-91;
asciiseq(spindex) = 0;
asciiseq(lfindex) = 4;
asciiseq(rindex)  = 5;
asciiseq(cindex)  = 1;
asciiseq(pindex)  = 2;
asciiseq(qindex)  = 3;

ascii = NaN*ones(1,length(as));
ascii(lindex)  = as(lindex);
ascii(spindex) = as(spindex);
ascii(lfindex) = as(lfindex);
ascii(rindex)  = as(rindex);
ascii(cindex)  = as(cindex);
ascii(pindex)  = as(pindex);
ascii(qindex)  = as(qindex);
ascii = ascii(find(~isnan(asciiseq)));

% build a new sequence that has the training sequence first, then all
% characters that didn't get left as NaNs, then five spaces.
asciiseq = [0:31 4 5 asciiseq(find(~isnan(asciiseq))) 0 0 0 0 0 0];

% drop off one of the trailing spaces if need be to make the length even
l=floor(length(asciiseq)/2)*2;
asciiseq = asciiseq(1:l);

%convert characters to binary strings, then to 2-bit symbols. Each column
%of bb is one pair of bits
bb=reshape(dec2bin(asciiseq)',2,length(asciiseq)*5/2);

%QPSK encoding
x = ((-1).^bb') * [1;j];