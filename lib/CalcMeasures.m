function result = CalcMeasures(Y, predY)
% result = [ACC, NMI, ARI, error_cnt];
if size(Y,2) ~= 1
    Y = Y';
end;
if size(predY,2) ~= 1
    predY = predY';
end;

% bestMap
predY = bestMap(Y, predY);
if size(Y)~=size(predY)
    predY=predY';
end
predLidx = unique(predY); 
pred_classnum = length(predLidx);
% purity
correnum = 0;
for ci = 1:pred_classnum
    incluster = Y(find(predY == predLidx(ci)));
%     cnub = unique(incluster);
%     inclunub = 0;
%     for cnubi = 1:length(cnub)
%         inclunub(cnubi) = length(find(incluster == cnub(cnubi)));
%     end;
    inclunub = hist(incluster, 1:max(incluster)); 
    if isempty(inclunub) inclunub=0;end;
    correnum = correnum + max(inclunub);
end;
Purity = correnum/length(predY);


error_cnt = sum(Y ~= predY);
AC = length(find(Y == predY))/length(Y);
[~,nmi_value,~] = compute_nmi(Y', predY');
[ARI,~,~,~] = valid_RandIndex(Y', predY');

result = [AC, nmi_value,Purity, ARI, error_cnt];
