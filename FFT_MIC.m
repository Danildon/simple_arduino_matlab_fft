clc;
clear all;
fclose('all');
delete(instrfind({'Port'},{'COM3'}));
arduino = serial('COM3', 'BaudRate', 250000);
fopen(arduino);

L=10000;
NFFT=2048;

for i=1:L

val = str2double(fscanf(arduino))  ;

if isnan(val)==0
    y(i) = val;
else
    y(i) = 500;
end

end

Fs=3731.34; %freq di campionamento di arduino, tempo tra una lettura e l'altra 268 us => Fs=3731.34

NFFT = 2^nextpow2(L);

Y = fft(y,NFFT)/L;

f = Fs/2*linspace(0,1,NFFT/2+1);

loglog(f,2*abs(Y(1:NFFT/2+1)));grid on;

title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')


