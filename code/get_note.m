
function note = get_note(frequency)
    default_octave = 4;
    octave = get_octave(frequency, default_octave); %computing the octave
    delta_octave = octave - default_octave;
    tone = get_tone(frequency/(2^delta_octave)); %computing the tone in the octave 4
        
    if (tone == 1)
        note = " C" + num2str(octave);
        
    elseif (tone == 2)
        note = "C#" + num2str(octave);
        
    elseif (tone == 3)
        note = " D" + num2str(octave);
        
    elseif (tone == 4)
        note = "D#" + num2str(octave);
    
    elseif (tone == 5)
        note = " E" + num2str(octave);
        
    elseif (tone == 6)
        note = " F" + num2str(octave);
        
    elseif (tone == 7)
        note = "F#" + num2str(octave);
        
    elseif (tone == 8)
        note = " G" + num2str(octave);
        
    elseif (tone == 9)
        note = "G#" + num2str(octave);
        
    elseif (tone == 10)
        note = " A" + num2str(octave);
        
    elseif (tone == 11)
        note = "A#" + num2str(octave);
        
    elseif (tone == 12)
        note = " B" + num2str(octave);
        
    else
        error('Error');
    end

end