clearvars;
close all;
format long g
clc

[roads, Fs] = audioread('greensleeves.wav');
Ts = 1/Fs;
N = length(roads);
t_final = (N-1)*Ts;

t=0:Ts:t_final;
x = roads(:,1);

%spectrogram of the signal
w = 1000;
spectrogram(x, hann(w), 3*w/4, 4*w, Fs, 'yaxis')
 

t_beg = 0.85;   % time window being analysed
t_end = t_final;

x_cut = x(t_beg*Fs+1:t_end*Fs);
t_cut = t(t_beg*Fs+1:t_end*Fs);


%% _________ PREPROCESSING _________

w = 2000; 
maximum = zeros(length(x_cut),1);
index = zeros(length(x_cut),1);

% applies maximum filter with moving window w
for i=1:w:length(x_cut)-w
    s = x_cut(i:i+w, 1);
    maximum(i) = max(s);
    index(i) = i;
end

index_new = nonzeros(index);
maximum_new = nonzeros(maximum);

t = length(maximum_new);
i=1;

% drops intermediate maximums during note attack;
while(i<=t-2)
   if(maximum_new(i+1)>maximum_new(i) && maximum_new(i+2)>maximum_new(i+1))
       maximum_new(i+1) = [];
       index_new(i+1) = [];
       t = t-1;
   else
       i=i+1;
   end
end


%%  __________  SOUND SEGMENTATION ____________________

times = index_new*Ts+t_beg; %converts indexes to times
notes_begin_time = zeros(length(times),1);

% plot of the signal after the preprocessing 
figure;
for i=1:1:length(times)
    line([times(i) times(i)], [0 maximum_new(i)]);
end
xlim([t_beg t_end])
xlabel('t[s]', 'FontSize', 15)
ylabel('x(t)', 'FontSize', 15)
title('Signal after preprocessing', 'FontSize', 15)

% detects the attack of a note and stores its time stamp
for i=1:1:length(times)-1
   if(maximum_new(i+1)-maximum_new(i)>0.1)
       notes_begin_time(i) = times(i);
   end
end

notes_begin_time = nonzeros(notes_begin_time)+0.05;

%addind the beggining og the first note and the end of the last note to the
%previous array
%time_extremes contains the beginning and end of each note (the end of a note coincides wih the beginning of the next one)
time_extremes = zeros(length(notes_begin_time)+2,1);
time_extremes(1) = t_beg;
time_extremes(end) = t_end;
time_extremes(2:end-1) = notes_begin_time;


%%  ________ PITCH RECOGNITION __________________

frequencies = zeros(length(time_extremes)-1,1);
notes = string(zeros(length(frequencies) ,1));

%identifying the frequency associated to each note, as well the pitch
for i=1:1:length(time_extremes)-1
    time_beg = time_extremes(i);
    time_end = time_extremes(i+1);
    sinal = x(round(time_beg/Ts):round(time_end/Ts));
    frequencies(i) = get_frequency(sinal, Fs);
    notes(i) = get_note(frequencies(i));
end

%printing the frequencies and pitches identified
for i=1:1:length(time_extremes)-1
    disp(['Tone ',num2str(i),':  ',num2str(notes(i)),'   f=',num2str(round(frequencies(i,1))),' Hz'])
end

% plot of the original signal, with vertical lines corresponding to the sound segmentation
figure;
plot(t_cut,x_cut)
xlim([t_beg t_end])
hold on;
for i=1:1:length(time_extremes)
    xline(time_extremes(i));
    hold on;
end
xlabel('t[s]', 'FontSize', 15)
ylabel('x(t)', 'FontSize', 15)
title('Segmented signal', 'FontSize', 15)

%% ______ SYNTHESIS OF THE SIGNAL ______________

x_synth = synth(time_extremes, frequencies, Fs);

% plays the sound
%sound(x_synth, Fs)

% stores the synhesised sound
% filename = 'greensleeves_synth.wav';
% audiowrite(filename,x_synth,Fs);

%% ______AUTOCORRELATION OF THE FIRST 5 NOTES______

figure;

for i=1:1:5
    time_beg = round(time_extremes(i),2);
    time_end = round(time_extremes(i+1),2);
    
    x_cut = x(time_beg*Fs+1:time_end*Fs);
    
    num_lags = 150;
    
    [autocor, lags] = autocorr(x_cut, num_lags);
    plot(lags, autocor);
    hold on;
end

legend('Note 1', 'Note 2', 'Note 3', 'Note 4', 'Note 5', 'FontSize', 13)
title('Autocorrelation', 'FontSize', 15)

