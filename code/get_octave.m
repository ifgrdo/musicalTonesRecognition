% recursive function that returns the octave of a note, given its frequency
function octave = get_octave(f, aux) 
    
    error = 5;
    f0 = 440;
  
    lower_bound = 2^(-9/12)*f0 - error; 
    upper_bound = 2^(3/12)*f0 - error; 
    
    if(f >= lower_bound & f <= upper_bound)
        octave = aux;
    
    elseif(f < lower_bound)
        octave = get_octave(2*f, aux-1);
    
    else
        octave = get_octave(f/2, aux+1);    
end
