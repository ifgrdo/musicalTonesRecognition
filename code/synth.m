function x_synth = synth(times, frequencies, Fs)

    times = round(times, 2);
    t_beg = 0;
    t_end = times(end);
    total_duration = t_end-t_beg;
    
    t  = linspace(0, total_duration, Fs*total_duration);
    x_synth = zeros(length(t),1);    
    
    %after identifying the time that corresponds to the beginning and end
    %of each note, we assign a sinusoidal function to that interval, with
    %frequency correspondent to the fundamental frequency of the note that
    %was played in that interval (each frequency was previoiusly obtained using DFT)
    
    for i=1:1:length(times)-1
        start_note = times(i);
        end_note = times(i+1);
        x_synth(round(start_note*Fs):round(end_note*Fs)) = sin(2*pi*frequencies(i)*t(round(start_note*Fs):round(end_note*Fs)));
    end    
end