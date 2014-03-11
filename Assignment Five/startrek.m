% LEARNING INPUT

% hardcoded data of ship names
ships_data = {'Grotz';'Tlarr';'Tribok';'Brogut';'Glorek';'Loref';'Rallev';'Willosh';'Loshar';'Sarash';'A2231';'E7763';'E9091';'A0199';'A1091';'Daisy';'Roseship';'Gardenia';'Herb';'Cinnamon'};
ships = [];
% all the possible consonants
consonant = ('BbCcDdFfGgHhJjKkLlMmNnPpQqRrSsTtVvWwXxYyZz');
% integers from 0-9
integer = ['0' '1' '2' '3' '4' '5' '6' '7' '8' '9'];

% checks to see if the ships are Klingon or Antarean or neither
for i=1:20
    check_klingon = 0;
    check_antarean = 0;
    check_neither = 0;
    current_ship = char(ships_data(i));
    % Klingon ships start with two consonants
    for j=1:42
        if current_ship(1) == consonant(j)
            for k=1:42
                if current_ship(2) == consonant(k)
                    ships(:,i) = [1 0 0];
                    check_klingon = 1;
                end
            end
        end
    end
    % Antarean ships start with A or E
    if current_ship(1) == 'A' || current_ship(1) == 'E'
        ships(:,i) = [0 1 0];
        check_antarean = 1;
    end
    % Ships that have a number for the second character is Antarean
    if current_ship ~= '*'
        for d=1:10
            if current_ship(2) == integer(d)
                ships(:,i) = [0 1 0];
                check_antarean = 1;
            end
        end
    end
    % Ships with no name could be any of them
    if current_ship == '*'
        ships(:,i) = [.3 .3 .3]
        check_neither = 1;
    end
    % Ships that are not klingon or Antarean are neither
    if check_klingon == 0 && check_antarean == 0 && check_neither == 0
        ships(:,i) = [0 0 1];
    end
end
    
% input of warp drive from the data
warp_drive_data = [6.9 7.0 7.3 7.1 7.1 7.3 7.4 7.3 7.2 7.4 6.7 6.8 6.5 6.8 6.7 6.7 6.8 6.5 6.4 6.5];
warp_drive = [];
for i=1:20
    % if warp drive is 0, the data for the warp drive is not available
    
    % if warp drive data does not exist, then the ship has an equally 
    % likely chance of being any of the warp drive ranges
    if warp_drive_data(:,i)== 0
        warp_drive(:,i) = [.125 .125 .125 .125 .125 .125 .125 .125];
    % if warp drive is 6.4, the ship is likely federation
    elseif warp_drive_data(:,i)>0 && warp_drive_data(:,i)<= 6.4
        warp_drive(:,i) = [1 0 0 0 0 0 0 0];
    % if warp drive is 6.5- 6.8, the ship is probably federation or
    % antarean
    elseif warp_drive_data(:,i) == 6.5
        warp_drive(:,i) = [0 1 0 0 0 0 0 0];
    elseif warp_drive_data(:,i) == 6.6
        warp_drive(:,i) = [0 0 1 0 0 0 0 0];
    elseif warp_drive_data(:,i) == 6.7 || warp_drive_data(i) == 6.8
        warp_drive(:,i) = [0 0 0 1 0 0 0 0];
    % if warp drive is 6.9- 7.1, the ship is klingon
    elseif warp_drive_data(:,i)<= 7.1 && warp_drive_data(i) > 6.8
        warp_drive(:,i) = [0 0 0 0 1 0 0 0];
    % if warp drive is 7.2- 7.3, the ship is likely romulan or klingon
    elseif warp_drive_data(:,i)== 7.2
        warp_drive(:,i) = [0 0 0 0 0 1 0 0];
    elseif warp_drive_data(:,i)== 7.3
        warp_drive(:,i) = [0 0 0 0 0 0 1 0];
    % if warp drive is greater than 7.4, the ship is likely romulan
    elseif warp_drive_data(:,i) > 7.3
        warp_drive(:,i) = [0 0 0 0 0 0 0 1];
    end
end

% input of hailer frequency from the data
hailer_freq_data = [ 1006.4 994.3 978.1 1005.4 1001.8 980.4 977.2 947.9 955.8 960.7 1010.9 1033.2 1025.4 1066.2 1015.0 1050.0 1055.0 1045.0 1065.0 1055.0];
hailer_freq = [];
for i=1:20
    % if hailer frequency is 10000, then the hailer frequency is considered
    % greater than 1000
    
    % if hailer frequency is greater than 1000, then the ship has an equally
    % likely chance of being Klingon, Antarean or Federation
    if hailer_freq_data(:,i) == 10000
        hailer_freq(:,i) = [0 0 .25 .25 .25 .25];
    % if hailer frequency is -10000, then the hailer frequency is
    % considered less than 1000
    
    % if hailer frequency is less than 1000, then the ship has an equally
    % likely chance of being any of the hailer frequency ranges less than 1000
    elseif hailer_freq_data(:,i) == -10000
        hailer_freq(:,i) = [.5 .5 0 0 0 0];
    % if hailer frequency is 0, the data for the hailer frequency is not
    % available
    
    % if hailer frequency data does not exist, then the ship has an equally
    % likely chance of being any of the hailer frequency ranges
    elseif hailer_freq_data(:,i) == 0
        hailer_freq(:,i) = [.167 .167 .167 .167 .167 .167];
    % hailer frequencies up to 978.0 are considered romulan
    elseif hailer_freq_data(:,i)<= 978.0 && hailer_freq_data(:,i) > 0
        hailer_freq(:,i) = [1 0 0 0 0 0];
    % hailer frequencies from 978.0 to 980.4 are considered
    % romulan or klingon
    elseif hailer_freq_data(:,i)<= 980.4 && hailer_freq_data(:,i) > 978.0
        hailer_freq(:,i) = [0 1 0 0 0 0];
    % hailer frequencies from 980.4 to 1008.7 are considered klingon
    elseif hailer_freq_data(:,i)<= 1008.7 && hailer_freq_data(:,i) > 980.4
        hailer_freq(:,i) = [0 0 1 0 0 0];
    % hailer frequencies from 1008.7 to 1044.9 are considered mostly Antarean
    elseif hailer_freq_data(:,i)<= 1044.9 && hailer_freq_data(:,i) > 1008.7
        hailer_freq(:,i) = [0 0 0 1 0 0];
    % hailer frequencies from above 1050.0 are considered mostly federation
    elseif hailer_freq_data(:,i)<= 1066.2 && hailer_freq_data(:,i) > 1044.9
        hailer_freq(:,i) = [0 0 0 0 1 0];
    elseif hailer_freq_data(:,i)> 1066.2
        hailer_freq(:,i) = [0 0 0 0 0 1];
    end
end

% input of color from the data
color_data = {'Black';'Black';'Dark Gray';'Dark Gray';'Light Gray';'Dark Blue';'Dark Green';'Light Gray';'Light Blue';'Light Gray';'Pink';'Orange';'Light Blue';'Yellow';'Light Blue';'White';'Light Gray';'White';'Light Gray';'Light Gray'};
color = [];
for i=1:20
    % black and dark gray ships are klingon
    if strcmp(color_data(i,:),'Black') || strcmp(color_data(i,:),'Dark Gray')
        color(:,i) = [1 0 0 0 0 0];
    % light gray ships are likely romulan or federation
    elseif strcmp(color_data(i,:),'Light Gray') 
        color(:,i) = [0 1 0 0 0 0];
    % dark blue or green ships are likely romulan
    elseif strcmp(color_data(i,:),'Dark Blue') || strcmp(color_data(i,:),'Dark Green')
        color(:,i) = [0 0 1 0 0 0];
    elseif strcmp(color_data(i,:),'Green')
        color(:,i) = [0 0 1 0 0 0];
    % light blue or blue ships are likely romulan or Antarean
    elseif strcmp(color_data(i,:),'Light Blue')
        color(:,i) = [0 0 0 1 0 0];
    elseif strcmp(color_data(i,:),'Blue')
        color(:,i) = [0 0 .5 .5 0 0];
    % pink, orange, or yellow ships are likely Antarean
    elseif strcmp(color_data(i,:),'Pink') || strcmp(color_data(i,:),'Orange') || strcmp(color_data(i,:),'Yellow')
        color(:,i) = [0 0 0 0 1 0];
    % white ships are likely federation
    elseif strcmp(color_data(i,:),'White')
        color(:,i) = [0 0 0 0 0 1];
    % if color is dark, then the ship has an equally
    % likely chance of being any of the dark color ranges
    elseif strcmp(color_data(i,:),'Dark Color') || strcmp(color_data(i,:),'Black or Dark Blue')
        color(:,i) = [.5 0 .5 0 0 0];
    % if color is light, then the ship has an equally
    % likely chance of being any of the light color ranges
    elseif strcmp(color_data(i,:),'Light Color')
        color(:,i) = [0 .3 0 .3 0 .3];
    % if color is *, the data for the color is not available
    
    % if color data does not exist, then the ship has an equally
    % likely chance of being any of the color ranges
    elseif strcmp(color_data(i,:),'*')
        color(:,i) = [.167 .167 .167 .167 .167 .167];
    end
end

% input of axis ratio from the data
axis_ratio_data = [3.5 3.3 2.8 2.3 1.0 1.6 1.8 1.9 2.1 2.3 1.2 1.2 1.1 1.3 1.0 1.9 2.0 2.1 2.6 1.7];
axis_ratio = [];
for i=1:20
    % if axis ratio is 0, the data for the axis ratio is not available
    
    % if axis ratio data does not exist, then the ship has an equally
    % likely chance of being any of the axis ratio ranges
    if axis_ratio_data(:,i) == 0
        axis_ratio(:,i) = [.2 .2 .2 .2 .2];
    % axis ratios from 1- 1.5 are likely Antarean
    elseif axis_ratio_data(:,i)<= 1.5 && axis_ratio_data(:,i)> 0
        axis_ratio(:,i) = [1 0 0 0 0];
    % axis ratios from 1.5- 1.8 are likely romulan
    elseif axis_ratio_data(:,i)<= 1.8 && axis_ratio_data(:,i)> 1.5
        axis_ratio(:,i) = [0 1 0 0 0];
    % axis ratios from 1.8- 2.2 are likely romulan or
    % federation
    elseif axis_ratio_data(:,i)<= 2.2 && axis_ratio_data(:,i)> 1.8
        axis_ratio(:,i) = [0 0 1 0 0];
    % axis ratios from 1- 1.5 are likely federation
    elseif axis_ratio_data(:,i)<= 2.7 && axis_ratio_data(:,i)> 2.2
        axis_ratio(:,i) = [0 0 0 1 0];
    % axis ratios greater than 2.7 are likely klingon
    elseif axis_ratio_data(:,i)> 2.7
        axis_ratio(:,i) = [0 0 0 0 1];
    end
end

% each ship's properties are vertically concatenated into a single vector
f = [];
for i=1:20
    f(:,i) = vertcat(ships(:,i),warp_drive(:,i),hailer_freq(:,i),color(:,i),axis_ratio(:,i));
end

% each of the 20 ships given are set to their preidentified states
g = [];
g(1,:) = [1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];
g(2,:) = [0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 ];
g(3,:) = [0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 ];
g(4,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 ];

% 5 sets of linear associators are created for each kind of data
A1 =linear_A(f,g);
A2 =linear_A(f,g);
A3 =linear_A(f,g);
A4 =linear_A(f,g);
A5 =linear_A(f,g);


% NEW INPUT FOLLOWS THE SAME RULES AND ASSUMPTIONS
ships_new_input = {'*';'*';'Lil__';'*';'Pl__ik';'*';'Krotork';'Woshif';'Kritop';'C06__';'*';'G__rk';'_9e__';'_6___';'Rash_';'Sor__';'A____';'E4511';'*';'Mor___'};
ships_new = [];
consonant = ('BbCcDdFfGgHhJjKkLlMmNnPpQqRrSsTtVvWwXxYyZz');
integer = ['0' '1' '2' '3' '4' '5' '6' '7' '8' '9'];

for i=1:20
    check_klingon = 0;
    check_antarean = 0;
    check_neither = 0;
    current_ship = char(ships_new_input(i));
    for b=1:42
        if current_ship(1) == consonant(b)
            for c=1:42
                if current_ship(2) == consonant(c)
                    ships_new(:,i) = [1 0 0];
                    check_klingon = 1;
                end
            end
        end
    end
    if current_ship(1) == 'A' || current_ship(1) == 'E'
        ships_new(:,i) = [0 1 0];
        check_antarean = 1; 
    end
    if current_ship ~= '*'
        for d=1:10
            if current_ship(2) == integer(d)
                ships_new(:,i) = [0 1 0];
                check_antarean = 1;
            end
        end
    end
    if current_ship == '*'
        ships_new(:,i) = [.3 .3 .3]
        check_neither = 1;
    end
    if check_klingon == 0 && check_antarean == 0 && check_neither == 0
        ships_new(:,i) = [0 0 1];
    end
end
    

warp_drive_new_input = [7.3 6.6 6.7 0 7.0 7.3 7.0 0 7.2 6.7 0 6.9 6.6 6.6 0 7.4 6.8 0 0 6.4];
warp_drive_new = [];
for i=1:20
    if warp_drive_new_input(:,i)== 0
        warp_drive_new(:,i) = [.125 .125 .125 .125 .125 .125 .125 .125];
    elseif warp_drive_new_input(:,i)>0 && warp_drive_new_input(:,i)<= 6.4
        warp_drive_new(:,i) = [1 0 0 0 0 0 0 0];
    elseif warp_drive_new_input(:,i) == 6.5
        warp_drive_new(:,i) = [0 1 0 0 0 0 0 0];
    elseif warp_drive_new_input(:,i) == 6.6
        warp_drive_new(:,i) = [0 0 1 0 0 0 0 0];
    elseif warp_drive_new_input(:,i) == 6.7 || warp_drive_new_input(i) == 6.8
        warp_drive_new(:,i) = [0 0 0 1 0 0 0 0];
    elseif warp_drive_new_input(:,i)<= 7.1 && warp_drive_new_input(i) > 6.8
        warp_drive_new(:,i) = [0 0 0 0 1 0 0 0];
    elseif warp_drive_new_input(:,i)== 7.2
        warp_drive_new(:,i) = [0 0 0 0 0 1 0 0];
    elseif warp_drive_new_input(:,i)== 7.3
        warp_drive_new(:,i) = [0 0 0 0 0 0 1 0];
    elseif warp_drive_new_input(:,i) > 7.3
        warp_drive_new(:,i) = [0 0 0 0 0 0 0 1];
    end
end

hailer_freq_new_input = [0 1065.0 1045.0 1065.0 1006.3 951.4 1001.8 971.7 0 0 0 10000 0 0 955.8 -10000 1013.3 0 10000 1055.0 ];
hailer_freq_new = [];
for i=1:20
    if hailer_freq_new_input(:,i) == 10000
        hailer_freq_new(:,i) = [0 0 .25 .25 .25 .25];
    elseif hailer_freq_new_input(:,i) == -10000
        hailer_freq_new(:,i) = [.5 .5 0 0 0 0];
    elseif hailer_freq_new_input(:,i) == 0
        hailer_freq_new(:,i) = [.167 .167 .167 .167 .167 .167];
    elseif hailer_freq_new_input(:,i)<= 978.0 && hailer_freq_new_input(:,i) > 0
        hailer_freq_new(:,i) = [1 0 0 0 0 0];
    elseif hailer_freq_new_input(:,i)<= 980.4 && hailer_freq_new_input(:,i) > 978.0
        hailer_freq_new(:,i) = [0 1 0 0 0 0];
    elseif hailer_freq_new_input(:,i)<= 1008.7 && hailer_freq_new_input(:,i) > 980.4
        hailer_freq_new(:,i) = [0 0 1 0 0 0];
    elseif hailer_freq_new_input(:,i)<= 1044.9 && hailer_freq_new_input(:,i) > 1008.7
        hailer_freq_new(:,i) = [0 0 0 1 0 0];
    elseif hailer_freq_new_input(:,i)<= 1066.2 && hailer_freq_new_input(:,i) > 1044.9
        hailer_freq_new(:,i) = [0 0 0 0 1 0];
    elseif hailer_freq_new_input(:,i)> 1066.2
        hailer_freq_new(:,i) = [0 0 0 0 0 1];
    end
end

color_new_input = {'Light Gray'; 'White'; 'White'; 'Light Color'; 'Dark Color'; 'Green'; 'Light Gray'; 'Blue'; 'Dark Gray'; 'Orange'; 'Black'; 'Black or Dark Blue'; 'Light Blue'; 'Orange'; 'Light Blue'; '*'; 'Light Color'; '*';  'Light Color'; '*'};
color_new = [];
for i=1:20
    if strcmp(color_new_input(i,:),'Black') || strcmp(color_new_input(i,:),'Dark Gray')
        color_new(:,i) = [1 0 0 0 0 0];
    elseif strcmp(color_new_input(i,:),'Light Gray') 
        color_new(:,i) = [0 1 0 0 0 0];
    elseif strcmp(color_new_input(i,:),'Dark Blue') || strcmp(color_new_input(i,:),'Dark Green')
        color_new(:,i) = [0 0 1 0 0 0];
    elseif strcmp(color_new_input(i,:),'Green')
        color_new(:,i) = [0 0 1 0 0 0];
    elseif strcmp(color_new_input(i,:),'Light Blue')
        color_new(:,i) = [0 0 0 1 0 0];
    elseif strcmp(color_new_input(i,:),'Blue')
        color_new(:,i) = [0 0 .5 .5 0 0];
    elseif strcmp(color_new_input(i,:),'Pink') || strcmp(color_new_input(i,:),'Orange') || strcmp(color_new_input(i,:),'Yellow')
        color_new(:,i) = [0 0 0 0 1 0];
    elseif strcmp(color_new_input(i,:),'White')
        color_new(:,i) = [0 0 0 0 0 1];
    elseif strcmp(color_new_input(i,:),'Dark Color') || strcmp(color_new_input(i,:),'Black or Dark Blue')
        color_new(:,i) = [.5 0 .5 0 0 0];
    elseif strcmp(color_new_input(i,:),'Light Color')
        color_new(:,i) = [0 .3 0 .3 0 .3];
    elseif strcmp(color_new_input(i,:),'*')
        color_new(:,i) = [.167 .167 .167 .167 .167 .167];
    end
end

axis_ratio_new_input = [2.1 2.1 0 0 0 1.9 1.0 1.7 2.9 0 2.6 3.2 1.2 0 0 0 1.0 0 1.7 0 ];
axis_ratio_new = [];
for i=1:20
    if axis_ratio_new_input(:,i) == 0
        axis_ratio_new(:,i) = [.2 .2 .2 .2 .2];
    elseif axis_ratio_new_input(:,i)<= 1.5 && axis_ratio_new_input(:,i)> 0
        axis_ratio_new(:,i) = [1 0 0 0 0];
    elseif axis_ratio_new_input(:,i)<= 1.8 && axis_ratio_new_input(:,i)> 1.5
        axis_ratio_new(:,i) = [0 1 0 0 0];
    elseif axis_ratio_new_input(:,i)<= 2.2 && axis_ratio_new_input(:,i)> 1.8
        axis_ratio_new(:,i) = [0 0 1 0 0];
    elseif axis_ratio_new_input(:,i)<= 2.7 && axis_ratio_new_input(:,i)> 2.2
        axis_ratio_new(:,i) = [0 0 0 1 0];
    elseif axis_ratio_new_input(:,i)> 2.7
        axis_ratio_new(:,i) = [0 0 0 0 1];
    end
end

f_new = [];
for i=1:20
    f_new(:,i) = vertcat(ships_new(:,i),warp_drive_new(:,i),hailer_freq_new(:,i),color_new(:,i),axis_ratio_new(:,i));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% output generated for the new input for each of the 5 associations
output1 = [];
output2 = [];
output3 = [];
output4 = [];
output5 = [];
for i=1:20
    output1(:,i) = A1*f_new(:,i);
    output2(:,i) = A2*f_new(:,i);
    output3(:,i) = A3*f_new(:,i);
    output4(:,i) = A4*f_new(:,i);
    output5(:,i) = A5*f_new(:,i);
end

output = mean(cat(3,output1,output2,output3,output4,output5),3);

% final output is displayed in terms of their planets' arbitrary number
planet = [];
for i=1:20
    for b=1:4
        if output(b,i) == max(output(:,i))
            if b==1
                disp('Klingon: Hostile');
            elseif b==2
                disp('Romulon: Alert');
            elseif b==3
                disp('Antarean: Friendly');
            elseif b==4
                disp('Federation: Friendly');
            else
                disp('Error');
            end
        end
    end
end