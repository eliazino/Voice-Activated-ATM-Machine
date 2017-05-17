function [jill] = codestack(d1,d2,sr)
warning off;
% Load two speech waveforms of the same utterance (from TIMIT)
 %[d1,sr] = speak(true);
 %[d2,sr] = speak(true);
%  d2 = d1;
 % Listen to them together:
%  ml = min(length(d1),length(d2));
%  soundsc(d1(1:ml)+d2(1:ml),sr)
%  % or, in stereo
%  soundsc([d1(1:ml),d2(1:ml)],sr)

 % Calculate STFT features for both sounds (25% window overlap)
 D1 = specgram(d1,512,sr,512,384);
 D2 = specgram(d2,512,sr,512,384);

 % Construct the 'local match' scores matrix as the cosine distance 
 % between the STFT magnitudes
 SM = simmx(abs(D1),abs(D2));
 % Look at it:
 subplot(121)
 imagesc(SM)
 colormap(1-gray)
 % You can see a dark stripe (high similarity values) approximately
 % down the leading diagonal.

 % Use dynamic programming to find the lowest-cost path between the 
 % opposite corners of the cost matrix
 % Note that we use 1-SM because dp will find the *lowest* total cost
 [p,q,C] = dp(1-SM);
 % Overlay the path on the local similarity matrix
 hold on; plot(q,p,'r'); hold off
 % Path visibly follows the dark stripe
 
 % Plot the minimum-cost-to-this point matrix too
 subplot(122)
 imagesc(C)
 hold on; plot(q,p,'r'); hold off
 % Bottom right corner of C gives cost of minimum-cost alignment of the two
 jill = C(size(C,1),size(C,2));
 end