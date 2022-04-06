function [ImageCepstrum] = MakeCepstrum(Image)
        
    for n=1:size(Image,3)                           %Start For loop for each scale.
        
        ImageDouble = double ( Image ( :, :, n ) ); %Convert input to double.
   
        ImageFourier = fft2 ( ImageDouble );        %Spectrum of image.
    
        FourierAbsolute = abs ( ImageFourier );     %Absolute of spectrum.
    
        FourierLog = log ( FourierAbsolute + 1 );   %Logarithm of absolute.
    
        FourierLogAbs = abs ( FourierLog );         %Absulute of logarithm.
    
        FourierEnergy = FourierLogAbs .^ 2;         %Power of 2.
    
        ImageCepstrum ( :, :, n ) = ifft2 ( FourierEnergy ); % Inverse transform.
                
    end
    
end
