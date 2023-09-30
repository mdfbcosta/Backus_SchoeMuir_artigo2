close all
clear all
clc

freq = [500 1000]; % As duas frequencias que temos

for j = 1:2 % Duas frequencias: 500 kHz e 1MHz
    
    if freq(j) == 500 ind = 500; else ind = 1000; end
    
    if ind == 500

        name = {'Samp 05','Samp 09','Samp 13','Samp 17','Samp 21','Samp 25',...
                'Samp 29','Samp 33','Samp 37','Samp 41','Samp 45','Samp 49',...
                'Samp 53','Samp 57','Samp 61','Samp 73'};
            
        name1 = {'Source transducer','Ref.: mort40+coar-sand60',...
                 'Ref.: cement100', 'Sample of 09 layers', 'Sample of 73 layers'};
            
        color = {'r','g','y','k','b','c','m','w','r','g','y','k','b','c','m','w'};
        shape = {'o','o','o','o','o','o','o','o','square','square','square','square','square','square','square','square'};
            
        f_max = load('freqMax500z.txt');
        A_max = load('AmplMax500z.txt');
        f = load('specfreq500z.txt');
        A = load('Amplfreq500z.txt');      
        n = size(f_max)
        
    elseif ind == 1000

        name = {'Samp 09','Samp 13','Samp 17','Samp 21','Samp 25','Samp 29',...
                'Samp 33','Samp 37','Samp 41','Samp 45','Samp 49','Samp 53',...
                'Samp 73'};
        color = {'g','y','k','b','c','m','w','r','g','y','k','b','w'};
        shape = {'o','o','o','o','o','o','o','square','square','square','square','square','square'};

        f_max = load('freqMax1000z.txt');
        A_max = load('AmplMax1000z.txt');
        f = load('specfreq1000z.txt');
        A = load('Amplfreq1000z.txt');        
        n = size(f_max)

    end
    
    %ploting the taller amplitude spectrum
    
    for i = 1:n(1,2)

        figure(1)
        
        if ind == 1000
            
            subplot(2,2,2)
            hold on
            plot(f_max(i),(A_max(i)),shape{i},'LineWidth',2,...
                            'MarkerEdgeColor','k',...
                            'MarkerFaceColor',color{i},...
                            'MarkerSize',9);
            grid on
            set(gca,'Fontsize',17);
            title('Dominant frequency (1 MHz)')        
            axis([0 250 40 4000])
            
        elseif ind == 500

            subplot(2,2,4)
            hold on
            plot(f_max(i),(A_max(i)),shape{i},'LineWidth',2,...
                            'MarkerEdgeColor','k',...
                            'MarkerFaceColor',color{i},...
                            'MarkerSize',9);
            grid on
            set(gca,'Fontsize',17);
            title('Dominant frequency (500 kHz)')
            legend(name)
            set(legend,'NumColumns',2);
            xlabel('Frequency [KHz]')            
            axis([0 250 40 4000])

        end
        
        set(gcf,'Position',[50 50 1400 1000]);
            
    end
    
    for i = 1:5

        figure(1)
        
        if ind == 1000
            
            subplot(2,2,1)
            hold on
            plot(f(:,i),abs(A(:,i)),'LineWidth',2)
            ylabel('Amplitude [a.u.]')            
            grid on
            set(gca,'Fontsize',17);
            title('Spectrum of frequency (1 MHz)')        
            axis([min(f(:,i)) 1.6e+3 min(A(:,i)) max(A(:,i))*1.1])
            
        elseif ind == 500

            subplot(2,2,3)
            hold on
            plot(f(:,i),abs(A(:,i)),'LineWidth',2)
            ylabel('Amplitude [a.u.]')             
            grid on
            set(gca,'Fontsize',17);
            title('Spectrum of frequency (500 kHz)')
            legend(name1)
            xlabel('Frequency [KHz]')            
            axis([min(f(:,i)) 1.6e+3 min(A(:,i)) max(A(:,i))*1.1])

        end
        
        set(gcf,'Position',[50 50 1400 1000]);
            
    end
    
clearvars f_max;
clearvars A_max
clearvars f;
clearvars A; 
    
end