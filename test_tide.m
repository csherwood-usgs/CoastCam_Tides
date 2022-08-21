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
% specify times at 1-h intervals
T=datenum(2022,02,10):1/24:datenum(2022,02,15);

% get the tides at times T
% this took about 8 minutes with my 4 Mbs internet

% tic;tid=predict_tide_full(lon,lat,T);toc
tic;tid=predict_tide_cape_cod(lon,lat,T);toc

%% Make a simple plot
figure(1);clf
line(T,tid,'LineWidth',1.5)
set(gca,'XTick',datenum(2020,7,1:15))
datetick('keeplimits','keepticks')
print -dpng tide_predict_HoM.png

%% Save the results, specifying mat-file format v7.3, which is HDF5
% see https://github.com/csherwood-usgs/BarMorph/blob/main/test_read_h5_mat_file.ipynb
% for an example of reading this back in Python
save('HoM_ADCIRC_tide_predictions.mat','lat','lon','T','tid','-v7.3')



