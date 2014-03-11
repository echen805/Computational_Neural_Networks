% LEARNING INPUT

% input of ships from the data
ships_input = {'Grotz';'Tlarr';'Tribok';'Brogut';'Glorek';'Loref';'Rallev';'Willosh';'Loshar';'Sarash';'A2231';'E7763';'E9091';'A0199';'A1091';'Daisy';'Roseship';'Gardenia';'Herb';'Cinnamon'};
ships = [];
% all possible consonants
consonant = ('BbCcDdFfGgHhJjKkLlMmNnPpQqRrSsTtVvWwXxYyZz');
% integers from 0-9
integer = ['0' '1' '2' '3' '4' '5' '6' '7' '8' '9'];

% checks if the ships are either klingon, anterean, or neither
for a=1:20
    check_klingon = 0;
    check_anterean = 0;
    check_empty = 0;
    current_ship = char(ships_input(a));
    % RULE: ships starting with 2 consonants = klingon
    for b=1:42
        if current_ship(1) == consonant(b)
            for c=1:42
                if current_ship(2) == consonant(c)
                    ships(:,a) = [1 0 0];
                    check_klingon = 1;
                end
            end
        end
    end
    % RULE: ships starting with A or E = anterean
    if current_ship(1) == 'A' || current_ship(1) == 'E'
        ships(:,a) = [0 1 0];
        check_anterean = 1;
    end
    % RULE: ships with the second element as a number = anterean
    if current_ship ~= '*'
        for d=1:10
            if current_ship(2) == integer(d)
                ships(:,a) = [0 1 0];
                check_anterean = 1;
            end
        end
    end
    % RULE: ships with no name have an equal chance of being klingon,
    % anterean or neither
    if current_ship == '*'
        ships(:,a) = [.3 .3 .3]
        check_empty = 1;
    end
    % RULE: ships that are not klingon or anterean are neither
    if check_klingon == 0 && check_anterean == 0 && check_empty == 0
        ships(:,a) = [0 0 1];
    end
end
    
% input of warp drive from the data
warp_drive_input = [6.9 7.0 7.3 7.1 7.1 7.3 7.4 7.3 7.2 7.4 6.7 6.8 6.5 6.8 6.7 6.7 6.8 6.5 6.4 6.5];
warp_drive = [];
for a=1:20
    % PREMISE: if warp drive is 0, the data for the warp drive is not
    % available
    % RULE: if warp drive data does not exist, then the ship has an equally
    % likely chance of being any of the warp drive ranges
    if warp_drive_input(:,a)== 0
        warp_drive(:,a) = [.125 .125 .125 .125 .125 .125 .125 .125];
    % RULE: if a warp drive falls into any one of these ranges, then it cannot
    % fall into the other ranges
    % ASSUMPTION: if warp drive is 6.4, the ship is likely federation
    elseif warp_drive_input(:,a)>0 && warp_drive_input(:,a)<= 6.4
        warp_drive(:,a) = [1 0 0 0 0 0 0 0];
    % ASSUMPTION: if warp drive is 6.5- 6.8, the ship is likely federation or
    % anterean
    elseif warp_drive_input(:,a) == 6.5
        warp_drive(:,a) = [0 1 0 0 0 0 0 0];
    elseif warp_drive_input(:,a) == 6.6
        warp_drive(:,a) = [0 0 1 0 0 0 0 0];
    elseif warp_drive_input(:,a) == 6.7 || warp_drive_input(a) == 6.8
        warp_drive(:,a) = [0 0 0 1 0 0 0 0];
    % ASSUMPTION: if warp drive is 6.9- 7.1, the ship is likely klingon
    elseif warp_drive_input(:,a)<= 7.1 && warp_drive_input(a) > 6.8
        warp_drive(:,a) = [0 0 0 0 1 0 0 0];
    % ASSUMPTION: if warp drive is 7.2- 7.3, the ship is likely romulan or
    % klingon
    elseif warp_drive_input(:,a)== 7.2
        warp_drive(:,a) = [0 0 0 0 0 1 0 0];
    elseif warp_drive_input(:,a)== 7.3
        warp_drive(:,a) = [0 0 0 0 0 0 1 0];
    % ASSUMPTION: if warp drive is greater than 7.4, the ship is likely
    % romulan
    elseif warp_drive_input(:,a) > 7.3
        warp_drive(:,a) = [0 0 0 0 0 0 0 1];
    end
end

% input of hailer frequency from the data
hailer_freq_input = [ 1006.4 994.3 978.1 1005.4 1001.8 980.4 977.2 947.9 955.8 960.7 1010.9 1033.2 1025.4 1066.2 1015.0 1050.0 1055.0 1045.0 1065.0 1055.0];
hailer_freq = [];
for a=1:20
    % PREMISE: if hailer frequency is 10000, then the hailer frequency is
    % considered greater than 1000
    % RULE: if hailer frequency is greater than 1000, then the ship has an equally
    % likely chance of being any of the hailer frequency ranges greater than 1000
    if hailer_freq_input(:,a) == 10000
        hailer_freq(:,a) = [0 0 .25 .25 .25 .25];
    % PREMISE: if hailer frequency is -10000, then the hailer frequency is
    % considered less than 1000
    % RULE: if hailer frequency is less than 1000, then the ship has an equally
    % likely chance of being any of the hailer frequency ranges less than 1000
    elseif hailer_freq_input(:,a) == -10000
        hailer_freq(:,a) = [.5 .5 0 0 0 0];
    % PREMISE: if hailer frequency is 0, the data for the hailer frequency is not
    % available
    % RULE: if hailer frequency data does not exist, then the ship has an equally
    % likely chance of being any of the hailer frequency ranges
    elseif hailer_freq_input(:,a) == 0
        hailer_freq(:,a) = [.167 .167 .167 .167 .167 .167];
    % ASSUMPTION: hailer frequencies up to 978.0 are considered romulan
    elseif hailer_freq_input(:,a)<= 978.0 && hailer_freq_input(:,a) > 0
        hailer_freq(:,a) = [1 0 0 0 0 0];
    % ASSUMPTION: hailer frequencies from 978.0 to 980.4 are considered
    % romulan or klingon
    elseif hailer_freq_input(:,a)<= 980.4 && hailer_freq_input(:,a) > 978.0
        hailer_freq(:,a) = [0 1 0 0 0 0];
    % ASSUMPTION: hailer frequencies from 980.4 to 1008.7 are considered
    % klingon
    elseif hailer_freq_input(:,a)<= 1008.7 && hailer_freq_input(:,a) > 980.4
        hailer_freq(:,a) = [0 0 1 0 0 0];
    % ASSUMPTION: hailer frequencies from 1008.7 to 1044.9 are considered
    % mostly anterean
    elseif hailer_freq_input(:,a)<= 1044.9 && hailer_freq_input(:,a) > 1008.7
        hailer_freq(:,a) = [0 0 0 1 0 0];
    % ASSUMPTION: hailer frequencies from above 1050.0 are considered
    % mostly federation
    elseif hailer_freq_input(:,a)<= 1066.2 && hailer_freq_input(:,a) > 1044.9
        hailer_freq(:,a) = [0 0 0 0 1 0];
    elseif hailer_freq_input(:,a)> 1066.2
        hailer_freq(:,a) = [0 0 0 0 0 1];
    end
end

% input of color from the data
color_input = {'Black';'Black';'Dark Gray';'Dark Gray';'Light Gray';'Dark Blue';'Dark Green';'Light Gray';'Light Blue';'Light Gray';'Pink';'Orange';'Light Blue';'Yellow';'Light Blue';'White';'Light Gray';'White';'Light Gray';'Light Gray'};
color = [];
for a=1:20
    % ASSUMPTION: black and dark gray ships are likely klingon
    if strcmp(color_input(a,:),'Black') || strcmp(color_input(a,:),'Dark Gray')
        color(:,a) = [1 0 0 0 0 0];
    % ASSUMPTION: light gray ships are likely romulan or federation
    elseif strcmp(color_input(a,:),'Light Gray') 
        color(:,a) = [0 1 0 0 0 0];
    % ASSUMPTION: dark blue or green ships are likely romulan
    elseif strcmp(color_input(a,:),'Dark Blue') || strcmp(color_input(a,:),'Dark Green')
        color(:,a) = [0 0 1 0 0 0];
    elseif strcmp(color_input(a,:),'Green')
        color(:,a) = [0 0 1 0 0 0];
    % ASSUMPTION: light blue or blue ships are likely romulan or anterean
    elseif strcmp(color_input(a,:),'Light Blue')
        color(:,a) = [0 0 0 1 0 0];
    elseif strcmp(color_input(a,:),'Blue')
        color(:,a) = [0 0 .5 .5 0 0];
    % ASSUMPTION: pink, orange, or yellow ships are likely anterean
    elseif strcmp(color_input(a,:),'Pink') || strcmp(color_input(a,:),'Orange') || strcmp(color_input(a,:),'Yellow')
        color(:,a) = [0 0 0 0 1 0];
    % ASSUMPTION: white ships are likely federation
    elseif strcmp(color_input(a,:),'White')
        color(:,a) = [0 0 0 0 0 1];
    % RULE: if color is dark, then the ship has an equally
    % likely chance of being any of the dark color ranges
    elseif strcmp(color_input(a,:),'Dark Color') || strcmp(color_input(a,:),'Black or Dark Blue')
        color(:,a) = [.5 0 .5 0 0 0];
    % RULE: if color is light, then the ship has an equally
    % likely chance of being any of the light color ranges
    elseif strcmp(color_input(a,:),'Light Color')
        color(:,a) = [0 .3 0 .3 0 .3];
    % PREMISE: if color is *, the data for the color is not
    % available
    % RULE: if color data does not exist, then the ship has an equally
    % likely chance of being any of the color ranges
    elseif strcmp(color_input(a,:),'*')
        color(:,a) = [.167 .167 .167 .167 .167 .167];
    end
end

% input of axis ratio from the data
axis_ratio_input = [3.5 3.3 2.8 2.3 1.0 1.6 1.8 1.9 2.1 2.3 1.2 1.2 1.1 1.3 1.0 1.9 2.0 2.1 2.6 1.7];
axis_ratio = [];
for a=1:20
    % PREMISE: if axis ratio is 0, the data for the axis ratio is not
    % available
    % RULE: if axis ratio data does not exist, then the ship has an equally
    % likely chance of being any of the axis ratio ranges
    if axis_ratio_input(:,a) == 0
        axis_ratio(:,a) = [.2 .2 .2 .2 .2];
    % ASSUMPTION: axis ratios from 1- 1.5 are likely anterean
    elseif axis_ratio_input(:,a)<= 1.5 && axis_ratio_input(:,a)> 0
        axis_ratio(:,a) = [1 0 0 0 0];
    % ASSUMPTION: axis ratios from 1.5- 1.8 are likely romulan
    elseif axis_ratio_input(:,a)<= 1.8 && axis_ratio_input(:,a)> 1.5
        axis_ratio(:,a) = [0 1 0 0 0];
    % ASSUMPTION: axis ratios from 1.8- 2.2 are likely romulan or
    % federation
    elseif axis_ratio_input(:,a)<= 2.2 && axis_ratio_input(:,a)> 1.8
        axis_ratio(:,a) = [0 0 1 0 0];
    % ASSUMPTION: axis ratios from 1- 1.5 are likely federation
    elseif axis_ratio_input(:,a)<= 2.7 && axis_ratio_input(:,a)> 2.2
        axis_ratio(:,a) = [0 0 0 1 0];
    % ASSUMPTION: axis ratios greater than 2.7 are likely klingon
    elseif axis_ratio_input(:,a)> 2.7
        axis_ratio(:,a) = [0 0 0 0 1];
    end
end

% each ship's properties are vertically concatenated into a single vector
f = [];
for a=1:20
    f(:,a) = vertcat(ships(:,a),warp_drive(:,a),hailer_freq(:,a),color(:,a),axis_ratio(:,a));
end

% each of the 20 ships given are set to their preidentified states
g = [];
g(1,:) = [1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];
g(2,:) = [0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 ];
g(3,:) = [0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 ];
g(4,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 ];

% 5 sets of outerproducts are generated due to the variability in the error
% correction technique
A1 =new_A(f,g);
A2 =new_A(f,g);
A3 =new_A(f,g);
A4 =new_A(f,g);
A5 =new_A(f,g);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEW INPUT FOLLOWS THE SAME RULES AND ASSUMPTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ships_new_input = {'*';'*';'Lil__';'*';'Pl__ik';'*';'Krotork';'Woshif';'Kritop';'C06__';'*';'G__rk';'_9e__';'_6___';'Rash_';'Sor__';'A____';'E4511';'*';'Mor___'};
ships_new = [];
consonant = ('BbCcDdFfGgHhJjKkLlMmNnPpQqRrSsTtVvWwXxYyZz');
integer = ['0' '1' '2' '3' '4' '5' '6' '7' '8' '9'];

for a=1:20
    check_klingon = 0;
    check_anterean = 0;
    check_empty = 0;
    current_ship = char(ships_new_input(a));
    for b=1:42
        if current_ship(1) == consonant(b)
            for c=1:42
                if current_ship(2) == consonant(c)
                    ships_new(:,a) = [1 0 0];
                    check_klingon = 1;
                end
            end
        end
    end
    if current_ship(1) == 'A' || current_ship(1) == 'E'
        ships_new(:,a) = [0 1 0];
        check_anterean = 1;
    end
    if current_ship ~= '*'
        for d=1:10
            if current_ship(2) == integer(d)
                ships_new(:,a) = [0 1 0];
                check_anterean = 1;
            end
        end
    end
    if current_ship == '*'
        ships_new(:,a) = [.3 .3 .3]
        check_empty = 1;
    end
    if check_klingon == 0 && check_anterean == 0 && check_empty == 0
        ships_new(:,a) = [0 0 1];
    end
end
    

warp_drive_new_input = [7.3 6.6 6.7 0 7.0 7.3 7.0 0 7.2 6.7 0 6.9 6.6 6.6 0 7.4 6.8 0 0 6.4];
warp_drive_new = [];
for a=1:20
    if warp_drive_new_input(:,a)== 0
        warp_drive_new(:,a) = [.125 .125 .125 .125 .125 .125 .125 .125];
    elseif warp_drive_new_input(:,a)>0 && warp_drive_new_input(:,a)<= 6.4
        warp_drive_new(:,a) = [1 0 0 0 0 0 0 0];
    elseif warp_drive_new_input(:,a) == 6.5
        warp_drive_new(:,a) = [0 1 0 0 0 0 0 0];
    elseif warp_drive_new_input(:,a) == 6.6
        warp_drive_new(:,a) = [0 0 1 0 0 0 0 0];
    elseif warp_drive_new_input(:,a) == 6.7 || warp_drive_new_input(a) == 6.8
        warp_drive_new(:,a) = [0 0 0 1 0 0 0 0];
    elseif warp_drive_new_input(:,a)<= 7.1 && warp_drive_new_input(a) > 6.8
        warp_drive_new(:,a) = [0 0 0 0 1 0 0 0];
    elseif warp_drive_new_input(:,a)== 7.2
        warp_drive_new(:,a) = [0 0 0 0 0 1 0 0];
    elseif warp_drive_new_input(:,a)== 7.3
        warp_drive_new(:,a) = [0 0 0 0 0 0 1 0];
    elseif warp_drive_new_input(:,a) > 7.3
        warp_drive_new(:,a) = [0 0 0 0 0 0 0 1];
    end
end

hailer_freq_new_input = [0 1065.0 1045.0 1065.0 1006.3 951.4 1001.8 971.7 0 0 0 10000 0 0 955.8 -10000 1013.3 0 10000 1055.0 ];
hailer_freq_new = [];
for a=1:20
    if hailer_freq_new_input(:,a) == 10000
        hailer_freq_new(:,a) = [0 0 .25 .25 .25 .25];
    elseif hailer_freq_new_input(:,a) == -10000
        hailer_freq_new(:,a) = [.5 .5 0 0 0 0];
    elseif hailer_freq_new_input(:,a) == 0
        hailer_freq_new(:,a) = [.167 .167 .167 .167 .167 .167];
    elseif hailer_freq_new_input(:,a)<= 978.0 && hailer_freq_new_input(:,a) > 0
        hailer_freq_new(:,a) = [1 0 0 0 0 0];
    elseif hailer_freq_new_input(:,a)<= 980.4 && hailer_freq_new_input(:,a) > 978.0
        hailer_freq_new(:,a) = [0 1 0 0 0 0];
    elseif hailer_freq_new_input(:,a)<= 1008.7 && hailer_freq_new_input(:,a) > 980.4
        hailer_freq_new(:,a) = [0 0 1 0 0 0];
    elseif hailer_freq_new_input(:,a)<= 1044.9 && hailer_freq_new_input(:,a) > 1008.7
        hailer_freq_new(:,a) = [0 0 0 1 0 0];
    elseif hailer_freq_new_input(:,a)<= 1066.2 && hailer_freq_new_input(:,a) > 1044.9
        hailer_freq_new(:,a) = [0 0 0 0 1 0];
    elseif hailer_freq_new_input(:,a)> 1066.2
        hailer_freq_new(:,a) = [0 0 0 0 0 1];
    end
end

color_new_input = {'Light Gray'; 'White'; 'White'; 'Light Color'; 'Dark Color'; 'Green'; 'Light Gray'; 'Blue'; 'Dark Gray'; 'Orange'; 'Black'; 'Black or Dark Blue'; 'Light Blue'; 'Orange'; 'Light Blue'; '*'; 'Light Color'; '*';  'Light Color'; '*'};
color_new = [];
for a=1:20
    if strcmp(color_new_input(a,:),'Black') || strcmp(color_new_input(a,:),'Dark Gray')
        color_new(:,a) = [1 0 0 0 0 0];
    elseif strcmp(color_new_input(a,:),'Light Gray') 
        color_new(:,a) = [0 1 0 0 0 0];
    elseif strcmp(color_new_input(a,:),'Dark Blue') || strcmp(color_new_input(a,:),'Dark Green')
        color_new(:,a) = [0 0 1 0 0 0];
    elseif strcmp(color_new_input(a,:),'Green')
        color_new(:,a) = [0 0 1 0 0 0];
    elseif strcmp(color_new_input(a,:),'Light Blue')
        color_new(:,a) = [0 0 0 1 0 0];
    elseif strcmp(color_new_input(a,:),'Blue')
        color_new(:,a) = [0 0 .5 .5 0 0];
    elseif strcmp(color_new_input(a,:),'Pink') || strcmp(color_new_input(a,:),'Orange') || strcmp(color_new_input(a,:),'Yellow')
        color_new(:,a) = [0 0 0 0 1 0];
    elseif strcmp(color_new_input(a,:),'White')
        color_new(:,a) = [0 0 0 0 0 1];
    elseif strcmp(color_new_input(a,:),'Dark Color') || strcmp(color_new_input(a,:),'Black or Dark Blue')
        color_new(:,a) = [.5 0 .5 0 0 0];
    elseif strcmp(color_new_input(a,:),'Light Color')
        color_new(:,a) = [0 .3 0 .3 0 .3];
    elseif strcmp(color_new_input(a,:),'*')
        color_new(:,a) = [.167 .167 .167 .167 .167 .167];
    end
end

axis_ratio_new_input = [2.1 2.1 0 0 0 1.9 1.0 1.7 2.9 0 2.6 3.2 1.2 0 0 0 1.0 0 1.7 0 ];
axis_ratio_new = [];
for a=1:20
    if axis_ratio_new_input(:,a) == 0
        axis_ratio_new(:,a) = [.2 .2 .2 .2 .2];
    elseif axis_ratio_new_input(:,a)<= 1.5 && axis_ratio_new_input(:,a)> 0
        axis_ratio_new(:,a) = [1 0 0 0 0];
    elseif axis_ratio_new_input(:,a)<= 1.8 && axis_ratio_new_input(:,a)> 1.5
        axis_ratio_new(:,a) = [0 1 0 0 0];
    elseif axis_ratio_new_input(:,a)<= 2.2 && axis_ratio_new_input(:,a)> 1.8
        axis_ratio_new(:,a) = [0 0 1 0 0];
    elseif axis_ratio_new_input(:,a)<= 2.7 && axis_ratio_new_input(:,a)> 2.2
        axis_ratio_new(:,a) = [0 0 0 1 0];
    elseif axis_ratio_new_input(:,a)> 2.7
        axis_ratio_new(:,a) = [0 0 0 0 1];
    end
end

f_new = [];
for a=1:20
    f_new(:,a) = vertcat(ships_new(:,a),warp_drive_new(:,a),hailer_freq_new(:,a),color_new(:,a),axis_ratio_new(:,a));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% output generated for the new input for each of the 5 associations
output1 = [];
output2 = [];
output3 = [];
output4 = [];
output5 = [];
for a=1:20
    output1(:,a) = A1*f_new(:,a);
    output2(:,a) = A2*f_new(:,a);
    output3(:,a) = A3*f_new(:,a);
    output4(:,a) = A4*f_new(:,a);
    output5(:,a) = A5*f_new(:,a);
end

% outputs are transformed to only contain the dominant element
output1 = transform(output1);
output2 = transform(output2);
output3 = transform(output3);
output4 = transform(output4);
output5 = transform(output5);

% outputs are added together to increase the actual dominance
output = output1 + output2 + output3 + output4 + output5;

% final output transformed to only contain dominant value
output = transform(output);

% final output is transformed in terms of their planets
planet = [];
for a=1:20
    for b=1:4
        if output(b,a)~=0
            if b==1
                planet(a) = 10;
            elseif b==2
                planet(a) = 20;
            elseif b==3
                planet(a) = 30;
            elseif b==4
                planet(a) = 40;
            end
        end
    end
end

% correct output of planets used for comparison
correct_planet = [20 40 40 40 10 20 10 20 10 30 10 10 30 30 20 20 30 30 40 40];

% displays all correctly learned planets and their necessary action
disputed_error = [];
for a=1:20
    if planet(a) ~= correct_planet(a)
        disp('Error');
        disputed_error(end+1) = a;
    elseif planet(a) == 10;
        disp('Klingon: Hostile');
    elseif planet(a) == 20;
        disp('Romulon: Alert');
    elseif planet(a) == 30;
        disp('Anterean: Friendly');
    elseif planet(a) == 40;
        disp('Federation: Friendly');
    end
end

% displays all planets with errors
error_size = size(disputed_error);
if error_size > 0
    for a=1:error_size(end)
        disp(disputed_error(a))
        if correct_planet(disputed_error(a)) == 10;
            disp('Klingon');
        elseif correct_planet(disputed_error(a)) == 20;
            disp('Romulon');
        elseif correct_planet(disputed_error(a)) == 30;
            disp('Anterean');
        elseif correct_planet(disputed_error(a)) == 40;
            disp('Federation');
        end
        disp('vs');
        if planet(disputed_error(a)) == 10;
            disp('Klingon');
        elseif planet(disputed_error(a)) == 20;
            disp('Romulon');
        elseif planet(disputed_error(a)) == 30;
            disp('Anterean');
        elseif planet(disputed_error(a)) == 40;
            disp('Federation');
        end
    end
end