%function that identifies the tones in the octave 4
%the entire algorithm is explained in the paper
function tone = get_tone(f)
    f0 = 440;
    
    f_C4 = 2^(-9/12) * f0;
    f_C4_sharp = 2^(-8/12) * f0;
    f_D4 = 2^(-7/12) *  f0;
    f_D4_sharp = 2^(-6/12) * f0;
    f_E4 = 2^(-5/12) * f0;
    f_F4 = 2^(-4/12) * f0;
    f_F4_sharp = 2^(-3/12) * f0;
    f_G4 = 2^(-2/12) *  f0;
    f_G4_sharp = 2^(-1/12) * f0;
    f_A4 = f0;
    f_A4_sharp = 2^(1/12) * f0;
    f_B4 = 2^(2/12) * f0;
    f_C5 = 2^(3/12) * f0;
    
    error = 5;
    
    if(f >= f_C4-error & f < f_C4_sharp-error)
        tone = 1;
        
    elseif(f >= f_C4_sharp-error & f < f_D4-error)
        tone = 2;
        
    elseif(f >= f_D4-error & f < f_D4_sharp-error)
        tone = 3;
        
    elseif(f >= f_D4_sharp-error & f < f_E4-error)
        tone = 4;

    elseif(f >= f_E4-error & f < f_F4-error)
        tone = 5;

    elseif(f >= f_F4-error & f < f_F4_sharp-error)
        tone = 6;

    elseif(f >= f_F4_sharp-error & f < f_G4-error)
        tone = 7;
    
    elseif(f >= f_G4-error & f < f_G4_sharp-error)
        tone = 8;

    elseif(f >= f_G4_sharp-error & f < f_A4-error)
        tone = 9;

    elseif(f >= f_A4-error & f < f_A4_sharp-error)
        tone = 10;

    elseif(f >= f_A4_sharp-error & f < f_B4-error)
        tone = 11;

    elseif(f >= f_B4-error & f < f_C5-error)
        tone = 12;
        
    else
        error('The given frequency does not belong to the middle C octave');
    end
end