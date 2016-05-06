The file 'gettysburg.mat' contains 5 signals that can be loaded
into the MATLAB workspace using

   >> load gettysburg


The variable
's' is the QPSK symbol sequence generated from the text file.  This
was done using the M-file 'text2bin.m' included here for reference.
Note that 's' should not be used as part of your algorithm, but it
is provided as a check on the adaptive filtering and demodulation.
If things worked perfectly, the symbol sequence you detect (before
you convert it to bits and then to text) would match 's'.

Note that upper-case characters are encoded as lower-case in this
conversion.

The variable x20 is a received data
sequence with no dispersion and an SNR given by the numerical
part of the signal name, i.e. x20 has a 20 dB SNR.

The variables x20_ti has time-invariant
dispersion added.  The variable x20_tv has time-varying dispersion added.
  
The function that performs the dispersion and noise addition is
not included here because then you would know what filter coefficients
I used.

Each of the signals is a data sequence formed from the text file
'gettysburg.txt' (also included in this distribution).
Each data sequence is pre-pended with the 32 character
training sequence, which is


 ,.'
abcdefghijklmnopqrstuvwxyz


(This occupies two lines because it includes a LINE FEED and
CARRIAGE RETURN character after the apostophe and before the
lower-case a.)  After the training sequence, there are two
spaces, and then the 'gettysburg.txt' text sequence.  Several
trailing spaces are added at the end.  Upper case characters
are then converted to lower case, and any characters not in our
limited 32-character alphabet are removed.  Each text
character is converted to a 5-bit binary representation, and
the resulting bit stream is converted, two bits at a time, into
the QPSK symbols.  The symbol stream is passed through the
channel, which adds dispersion and noise according as appropriate
for the particular version of interest (e.g., x20_tv gets both
time-varying dispersion and noise at a 20 dB SNR).

The variable 'd' is the 32-character training sequence, converted
to clean QPSK.  This can be useful as the "desired signal" in your
LMS algorithm


-- ECE 4271 ---
