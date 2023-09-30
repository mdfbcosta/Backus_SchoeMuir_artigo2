%close all
clear all
clc

freq = [500 1000]; % As duas frequencias que temos

for j = 1:2 % Duas frequencias: 500 kHz e 1MHz
    
    if freq(j) == 500 ind = 500; else ind = 1000; end
    
    if ind == 500

        name = {'Samp 05','Samp 09','Samp 13','Samp 17','Samp 21','Samp 25',...
                'Samp 29','Samp 33','Samp 37','Samp 41','Samp 45','Samp 49',...
                'Samp 53','Samp 57','Samp 61','Samp 73'};
        color = {'r','g','y','k','b','c','m','w','r','g','y','k','b','c','m','w'};
        shape = {'o','o','o','o','o','o','o','o','square','square','square',...
                 'square','square','square','square','square'};           
            
        f_max = load('freqMax500x.txt');
        A_max = load('AmplMax500x.txt');
        f = load('specfreq500x.txt');
        A = load('Amplfreq500x.txt');      
        n = size(f_max);
        n2 = size(f);
        n3 = 7;
        quem = [2 3 7 8 11 13 1];
        
    elseif ind == 1000

        name = {'Samp 09','Samp 13','Samp 17','Samp 21','Samp 25','Samp 29',...
                'Samp 33','Samp 37','Samp 41','Samp 45','Samp 49','Samp 53',...
                'Samp 73'};
            
        color = {'g','y','k','b','c','m','w','r','g','y','k','b','w'};
        shape = {'o','o','o','o','o','o','o','square','square','square',...
                 'square','square','square'};

        f_max = load('freqMax1000x.txt');
        A_max = load('AmplMax1000x.txt');
        f = load('specfreq1000x.txt');
        A = load('Amplfreq1000x.txt');        
        n = size(f_max);
        n2 = size(f);
        n3 = 6;
        quem = [1 2 6 7 10 12];

    end
    
    % ploting the taller amplitude spectrum *******************************
    
    for i = 1:n(1,2)

        figure(2)
        
        if ind == 1000
            
            subplot(2,2,2)
            hold on
            plot(f_max(i),(A_max(i)),shape{i},'LineWidth',2,...
                            'MarkerEdgeColor','k',...
                            'MarkerFaceColor',color{i},...
                            'MarkerSize',9);
            grid on
            set(gca,'Fontsize',17);
            title('Domin. freq. (1 MHz)')        
            axis([0 500 40 4000])
            
        elseif ind == 500

            subplot(2,2,4)
            hold on
            plot(f_max(i),(A_max(i)),shape{i},'LineWidth',2,...
                            'MarkerEdgeColor','k',...
                            'MarkerFaceColor',color{i},...
                            'MarkerSize',9);
            grid on
            set(gca,'Fontsize',17);
            title('Domin. freq. (500 kHz)')
            legend(name)
            set(legend,'NumColumns',2);
            xlabel('Frequency [KHz]')            
            axis([0 500 40 4000])

        end
        
        set(gcf,'Position',[50 50 1400 1000]);
            
    end
    
    %**********************************************************************
    
    for o = 1:n3
    in = quem(o);
    name3{o} = name{in};
    end
    shape3 = {'-','-','-','-','-','-','--'};  

    for ii = 1:n3
        i = quem(ii);
        
        figure(2)
        
        if ind == 1000
            
                subplot(2,2,1)
                hold on
                plot(f(:,i),abs(A(:,i)),shape3{ii},'LineWidth',3)
                grid on
                set(gca,'Fontsize',17);
                axis([min(f(:,i)) 500 min(A(:,i)) max(A(:,i))*1.1])
                title('Spect. freq. (1 MHz)')
                ylabel('Amplitude [a.u.]')
            
        elseif ind == 500

                subplot(2,2,3)
                title('Spect. freq. (500 kHz)')
                ylabel('Amplitude [a.u.]')
                hold on
                plot(f(:,i),abs(A(:,i)),shape3{ii},'LineWidth',3)
                grid on
                set(gca,'Fontsize',17);
                legend(name3)
                xlabel('Frequency [KHz]')
                axis([min(f(:,i)) 500 min(A(:,i)) max(A(:,i))*1.1])
                
        end
        
        set(gcf,'Position',[50 50 1400 1000]);
            
    end
    
clearvars f_max;
clearvars A_max
clearvars f;
clearvars A; 
    
end