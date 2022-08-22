% CC_tide - Grab tide predictions for outer cape
%
% Required: t_tide package https://www.eoas.ubc.ca/~rich/#T_Tide
% and two addtional m files:
%    predict_tide_full.m
%    t_predict_loc.m
% aaretxabaleta@usgs.gov, slight changes by csherwood@usgs.gov

% a bunch of locations between top of CC and Chatham
% latlon = [...
% 				-70.17879464654621,42.09827865159543;...
%                 -70.10092248092475,42.08105297840604;...
%                 -70.05083780122145,42.0604936282217;...
%                 -70.01239376846983,42.02601104722612;...
%                 -69.98917059946191,41.99419623776291;...
%                 -69.9668734710975,41.96106954459676;...
%                 -69.95084025255659,41.92662912282462;...
%                 -69.93572011338924,41.88425747330653;...
%                 -69.92151392586787,41.84652500172901;...
%                 -69.91709629872508,41.81078559510066;...
%                 -69.91091426541486,41.76776356577808;...
%                 -69.90918029748387,41.72606190107396;...
%                 -69.90744805884536,41.68435002796038;...
%                 -69.91811311796906,41.65653687811353];
% lon = latlon(:,2)
% lat = latlon(:,1)

% specify location near Head of the Meadow beach
lat=42.061859;
lon=-70.081760;

% another location close to Marconi Beach
lat2=41.893957;
lon2=-69.959093;

% specify times at 1-h intervals
T=datenum(2019,10,1):1/24:datenum(2022,12,31);

% get the tides at times T
% this took about 3 minutes with my 4 Mbs internet

% This one has data for a larger region, but is slower:
% tic;tid=predict_tide_full(lon,lat,T);toc

% This one is local to Cape Cod and faster:
tic;tid=predict_tide_capecod(lon,lat,T);toc

tic;tid2=predict_tide_capecod(lon2,lat2,T);toc


%% Make a simple plot
figure(1);clf
h1=plot(T,tid,'LineWidth',1.5);
hold on
h2=plot(T,tid2,'LineWidth',1.5);

%set(gca,'XTick',datenum(2019,10,10:15))
datetick('keeplimits','keepticks')
print -dpng tide_predict_HoM_and_Marconi.png

%% Save the results, specifying mat-file format v7.3, which is HDF5
% see https://github.com/csherwood-usgs/BarMorph/blob/main/test_read_h5_mat_file.ipynb
% for an example of reading this back in Python
save('HoM_ADCIRC_tide_predictions.mat','lat','lon','T','tid','-v7.3')
save('Marconi_ADCIRC_tide_predictions.mat','lat','lon','T','tid','-v7.3')



