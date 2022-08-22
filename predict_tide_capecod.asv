function tid=predict_tide_capecod(lon,lat,time)
%PREDICT_TIDEW predicts the tide for a specific lon/lat location.
%   It reads the elevation file of the ADCIRC tidal database 
%   (https://adcirc.org/products/adcirc-tidal-databases/)  
%
%
%   Input :   lon - Longitude of location
%             lat - Latitude of location
%             time - matlab time
%
%  Output :   tid - tidal prediction 
%

% Calculate tides
%nctid=ncgeodataset('http://geoport.whoi.edu/thredds/dodsC/sand/usgs/users/aretxabaleta/ADCIRC_tides/f53.nc');
%nctid=ncgeodataset('http://tds.renci.org:8080/thredds/dodsC/DataLayers/Tides/ec2015_tidaldb/f53.nc');
%fname='http://tds.renci.org:8080/thredds/dodsC/DataLayers/Tides/ec2015_tidaldb/f53.nc';
fname='http://geoport.whoi.edu/thredds/dodsC/vortexfs1/usgs/users/aretxabaleta/ADCIRC_tides/f53.nc';


nam=ncread(fname,'Names')';
freq=ncread(fname,'Frequencies')';

nam0=double(nam);
ou=0;
for oo=1:length(freq)
    ou=ou+1;
    dum=nam0(oo,:);
    dum(dum==32)=[];
    enc=find(dum==0,1,'first');
    nam2{ou}=char(dum(1:enc-1));
end
nam(11,1:7)='LDA2   ';nam(12,1:7)='MU2    ';nam(13,1:7)='NU2    ';nam(15,1:7)='M1     ';
nam(20,1:7)='RHO1   ';nam(29,1:7)='2MK5   ';nam(33,1:7)='MF     ';nam(34,1:7)='MSF    ';
nam(35,1:7)='MM     ';nam(36,1:7)='SA     ';nam(37,1:7)='SSA    ';
nam2{11}='LDA2';nam2{12}='MU2';nam2{13}='NU2';nam2{15}='M1';
nam2{20}='RHO1';nam2{29}='2MK5';nam2{33}='MF';nam2{34}='MSF';
nam2{35}='MM';nam2{36}='SA';nam2{37}='SSA';

%g=loadgrid('ec2012'); 
%ind=findelem(g,[lon,lat]);

lom=ncread(fname,'lon');
lam=ncread(fname,'lat');

tamp1=ncread(fname,'Amp',[1 1],[Inf 1]);


F=scatteredInterpolant(lom,lam,tamp1);
for i=1:length(lat)
    tamp(1)=F(lon(i),lat(i));
    for j=2:length(freq)
        F.Values=ncread(fname,'Amp',[1 j],[Inf 1]);
        tamp(j)=F(lon(i),lat(i));
    end
    for j=1:length(freq)
        F.Values=ncread(fname,'Pha',[1 j],[Inf 1]);
        tpha(j)=F(lon(i),lat(i));
    end

    tcon=[tamp',tamp'*0,tpha',0*tpha'];
    
    tid(i,:)=(t_predict_loc(time(:),nam2,nam,freq*3600/2/pi,tcon,lat(i)));
end
