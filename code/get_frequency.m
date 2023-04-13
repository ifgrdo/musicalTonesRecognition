function frequency = get_frequency(signal, Fs)
    tam = length(signal);
    f = (0:tam-1)*Fs/tam;
    y = fft(signal, tam);
    magnitude = abs(y);
    phase = unwrap(angle(y));

    %plot of magnitude and phase of the signal in the frequency domain 
    %figure;
    %plot(f,magnitude);
    %xlim([0 floor(Fs/2)]);
    %xlabel('f [Hz]');
    %ylabel('| X(k) |');

    %figure;
    %plot(f,phase);
    %xlim([0 floor(Fs/2)]);
    %xlabel('f [Hz]');
    %ylabel('Abs (X(k)) [rad]');
    
    [magnitude_max, index_max] = maxk(magnitude, 1); %identifies the peak with maximum magnitude
    f = (index_max-1)*Fs/tam; %computes the frequency associated with that peak
    frequency = f;
    
    %verifies if the found peak corresponds to the fundamental frequency or
    %or to a harmonic: to do this, we do two iterations, dividing the found
    %frequency by 2 and 4. then, if the magnitude associated with this new
    %value of frequency is bigger than a certain threshold
    %(magnitude_max/4), it means that the current peak corresponds to the fundamental
    %frequency, and not the one found before
    %
    for i=1:1:2
        f_sub_estimated = f/(2^i);
        f_min_sub = f_sub_estimated - 10;
        f_max_sub = f_sub_estimated + 10;
        
        index_min_sub = round(f_min_sub*tam/Fs+1);
        index_max_sub = round(f_max_sub*tam/Fs+1);
        
        [magnitude_max_sub, index_max_found] = maxk(magnitude(index_min_sub:index_max_sub), 1);
        
        if(magnitude_max_sub >= magnitude_max/4)
            f_sub_computed = (index_max_found+index_min_sub-1)*Fs/tam;
            frequency = f_sub_computed;
        end
    end 
end