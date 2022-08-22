% test_tide - Demonstrate grabbing tide predictions from ADCIRC model
%
% Required: t_tide package https://www.eoas.ubc.ca/~rich/#T_Tide
% and two addtional m files:
%    predict_tide_full.m
%    t_predict_loc.m
% aaretxabaleta@usgs.gov, slight changes by csherwood@usgs.gov

% specify location near Head of the Meadow beach
lat=42.061859;
lon=-70.081760;

% another location close to Marconi Beach
lat2=41.893957;
lon2=-69.959093;

% specify times at 1-h intervals
T=datenum(2022,02,10):1/24:datenum(2022,02,15);

% get the tides at times T
% this took about 3 minutes with my 4 Mbs internet

% This one has data for a larger region, but is slower:
% tic;tid=predict_tide_full(lon,lat,T);toc

% This one is local to Cape Cod and faster:
tic;tid=predict_tide_capecod(lon,lat,T);toc

tic;tid2=predict_tide_capecod(lon2,lat2,T);toc


%% Make a simple plot
figure(1);clf
line(T,tid,'LineWidth',1.5)
hold on
line(T,tid2,'LineWidth',1.5)

set(gca,'XTick',datenum(2022,2,10:15))
datetick('keeplimits','keepticks')
print -dpng tide_predict_HoM.png

%% Save the results, specifying mat-file format v7.3, which is HDF5
% see https://github.com/csherwood-usgs/BarMorph/blob/main/test_read_h5_mat_file.ipynb
% for an example of reading this back in Python
save('HoM_ADCIRC_tide_predictions.mat','lat','lon','T','tid','-v7.3')



