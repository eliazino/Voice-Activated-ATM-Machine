filename = 'intro.wav';
[y2, Fs2]= audioread(filename);
Fs2 = 60000;
drill = audioplayer(y2, Fs2);
play(drill);
disp('Please speak paraphrase after the tone...');
pause(9);
filename = 'OH75.WAV';
[y, F]= audioread(filename);
dri = audioplayer(y, F);
play(dri);