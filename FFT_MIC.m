%% ==================== Arduino FFT Data Acquisition ====================
clc;
clear;
fclose('all');                  % Close any open serial connections
delete(instrfind({'Port'},{'COM3'}));  % Delete any previous COM objects

% -------------------- Serial Setup --------------------
port = 'COM3';
baudRate = 250000;
arduino = serial(port, 'BaudRate', baudRate);
fopen(arduino);

% -------------------- Acquisition Parameters --------------------
numSamples = 10000;            % Number of samples to acquire
Fs = 3731.34;                   % Sampling frequency in Hz (268 us interval)
defaultValue = 500;             % Default value if read fails

% Preallocate array for efficiency
y = zeros(1, numSamples);

% -------------------- Data Acquisition --------------------
for i = 1:numSamples
    val = str2double(fscanf(arduino));  % Read numeric value from Arduino
    
    if ~isnan(val)
        y(i) = val;
    else
        y(i) = defaultValue;
    end
end

fclose(arduino);
delete(arduino);

% -------------------- FFT Analysis --------------------
NFFT = 2^nextpow2(numSamples);        % Next power of 2 for FFT
Y = fft(y, NFFT) / numSamples;        % Normalize FFT

f = Fs/2 * linspace(0,1,NFFT/2 + 1);  % Frequency vector

% -------------------- Plotting --------------------
figure;
loglog(f, 2*abs(Y(1:NFFT/2 + 1)), 'LineWidth', 1.5);
grid on;
title('Single-Sided Amplitude Spectrum of y(t)', 'FontWeight', 'bold');
xlabel('Frequency (Hz)', 'FontWeight', 'bold');
ylabel('|Y(f)|', 'FontWeight', 'bold');
