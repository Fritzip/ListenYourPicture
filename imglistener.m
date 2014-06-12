% Import Image
img = imread('fig2.png');
img = double(rgb2gray(img));
img = ones(size(img))*255 - double(img);

% Fuzzy Filter
h=fspecial('average');
img =filter2(h,img); img =filter2(h,img);

% Define Parameters
nfft = 256;
ovlp = 99;
hop = round(nfft*ovlp/100);
fs = 11025;
durree = 2; % sec 

% Modify Img to make it compatible with istft
iheight = (nfft / 2) + 1;
iweight = round(durree*fs/hop);
img = imresize(img, [iheight, iweight]);

% Estimate phase
% (later)

% Convert into audio signal
[x, t] = myistft(img, hop, nfft, fs);

[S, F, T] = mystft(x, nfft, hop, nfft, fs);

% Plot
imagesc(T,F,abs(S)); set(gca,'YDir','normal')

wavwrite(x,fs,'myfirstsound.wav');
%%

% Read .wav file
[x, fs] = wavread('lipo.WAV');

% Define analysis and synthesis parameters
wlen = 2048;
h = wlen/4;
nfft = wlen;

% Perform time-frequency analysis
[S, ~, ~] = mystft(x, wlen, h, nfft, fs);

% resynthesis of the original signal
[x_istft, t_istft] = myistft(S, h, nfft, fs);