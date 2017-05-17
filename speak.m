function [ wavarray, Fs ] = speak(invoker)
%SPEAK Summary of this function goes here
%   Detailed explanation goes here
if invoker
    Fs = 11025;
    y = wavrecord(5*Fs,Fs,'int16');
%     recObj = audiorecorder;
%     recordblocking(recObj, 5);
    wavarray = y; %getaudiodata(recObj);
end
end