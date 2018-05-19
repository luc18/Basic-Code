%此文件为总氧气平衡模型。
%a：静态水体溶解氧浓度计算式()；
%b：非稳态水体溶解氧浓度计算式()；
%c：水生植物光合作用计算式()；
%d：底泥呼吸计算式()；
%e：水呼吸耗氧公式()；
%% 
nde = 144/24;%                      %结束查看天数
nds = 0;%                           %开始查看天数
mnl = 24*nds+1;                     %查看点
mne = 24*nde;                       %查看点
mstep = 24; %时间间隔
yearn = 20128;%查看年份
%% 数据列:1风速，2气温,3降雨，4大气压
load ( [ 'jingzhou_' num2str(yearn) '_realdata.mat' ] )
%% 时间序列数据
    Patm = alldata(mnl:mne,1)./101.325./100;     % 大气压；单位：atm
    Tempe = alldata(mnl:mne,2).*0.1;             % 各小时气温
    raind = alldata(mnl:mne,3);                  % 降雨强度，降雨强度，mm/h
    US = alldata(mnl:mne,4)./10;                 % 10m处风速
    Lid = alldata(mnl:mne,7)*3600.*0.945./1000/1000;        % 光强；单位：Jm,7\8可选
    TSt =1: (mne-mnl+1); 
    psize = 10.5;
  %% subplot
subplot(snn,1,1)
%     set(gca,'Position',[0.13 0.84 0.775 0.08])
    [AX1,H1,H2] = plotyy(TSt,US,TSt,Patm);%'b'
    set(H1,'color','k','linewidth',2)%'k'
    set(H2,'color',[0.2 0.4 1],'linewidth',2)%'b'
    set(AX1(1),'ylim',[max(0,floor(min(US))),ceil(max(US))])
    set(AX1(2),'ylim',[max(0,floor(min(Patm)*100)./100),ceil(max(Patm)*100)./100])
    set(AX1,'xlim',[TSt(1),TSt(end)],'xtick',TStt,'xticklabel',[])
    set(get(AX1(1),'Ylabel'),'string',{'10m 风速' ; 'm/s'},'FontSize',psize,'FontName','Times New Roman');%y轴标题字号
    set(get(AX1(2),'Ylabel'),'string',{'大气压' ; 'Mpa'},'FontSize',psize,'FontName','Times New Roman');%x坐标标题
    set(AX1(1),'Ycolor','k') 
    set(AX1(2),'Ycolor',[0.2 0.4 1]) 
    box off 
%     box off 
%     ylabel({'气温（℃）'},'fontsize',psize);%
subplot(snn,1,2)
    plot(TSt,Lid,'-','color',[1 0 1],'linewidth',2)%100,'c'
    xlim([TSt(1),TSt(end)]);
    ylim([max(0,floor(min(Lid))),ceil(max(Lid)*10)./10]);
    set(gca,'xtick',[],'xticklabel',[]); %只显示x坐标轴刻度，不显示x坐标轴的值； 
    box off 
    ylabel({'辐射量' ; 'MJ/m^2'},'fontsize',psize,'FontName','Times New Roman');%  
    set(gca,'YColor',[1 0 1]);
%     [AX2,H3,H4] = plotyy(TSt,Lid,TSt,raind);%'b'
%     set(H3,'color','R','linewidth',2)
%     set(H4,'color',[1 1 1].*0.4,'linewidth',2)
%     set(AX2(1),'ylim',[max(0,floor(min(Lid))),ceil(max(Lid)*10)./10],'xlim',[TSt(1),TSt(end)],'xtick',[])%,'ytick',[0:0.1:0.5]  
%     set(AX2(2),'ylim',[max(0,floor(min(raind))),ceil(max(raind)*10)./10],'xlim',[TSt(1),TSt(end)],'xtick',[])%,'ytick',[0:1:3]
%     set(get(AX2(1),'Ylabel'),'string',{'辐射量' ; 'MJ/m^2'},'FontSize',psize,'FontName','Times New Roman');%设置右y轴标题字号字型  
%     set(get(AX2(2),'Ylabel'),'string',{'降雨量' ; 'mm/h'},'FontSize',psize,'FontName','Times New Roman');%设置x坐标标题
%     box off 
subplot(snn,1,3)
%     set(gca,'Position',[0.13 0.54 0.775 0.08])
%     plot(TSt,Tempe,'-','color','c','linewidth',2)%100,'c'
%     xlim([TSt(1),TSt(end)]);
%     ylim([max(0,floor(min(Tempe))),ceil(max(Tempe)*10)./10]);
%     set(gca,'xtick',[],'xticklabel',[]); %只显示x坐标轴刻度，不显示x坐标轴的值； 
%     box off 
%     ylabel({'气温' ; '℃'},'fontsize',psize);%    
    indexr = (raind==0);
    TStr = TSt(~indexr);
    raindr = raind(~indexr);
    [AX2,H3,H4] = plotyy(TSt,Tempe,TStr,raindr,'plot','bar');%'b'
    set(H3,'color','r','linewidth',2)
    set(H4,'FaceColor',[0 0.8 0.4],'EdgeColor',[1,1,1]*0.3,'linewidth',2,'BarWidth',1)%'BarLayout','stacked'
%     set(H4,'color',[0 0.8 0.4],'linewidth',2,'Marker','o','MarkerSize',5,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0.8 0.4])%'c'
    set(AX2(1),'ylim',[max(0,floor(min(Tempe))),ceil(max(Tempe)*10.2)./10])
    set(AX2(2),'ylim',[max(0,floor(min(raind))),ceil(max(raind)*12)./10])
    set(AX2,'xlim',[TSt(1),TSt(end)],'xtick',TStt,'xticklabel',[])
    set(get(AX2(1),'Ylabel'),'color','R','string',{'气温' ; '℃'},'FontSize',psize,'FontName','Times New Roman');  
    set(get(AX2(2),'Ylabel'),'color',[0 0.8 0.4],'string',{'降雨量' ; 'mm/h'},'FontSize',psize,'FontName','Times New Roman');
    set(AX2(1),'Ycolor','r') 
    set(AX2(2),'Ycolor',[0 0.8 0.4]) 
    box off 
%     p1 = 0.85;%0.195
%     p2 = -0.03;
% annotation('textbox',[p1 0.91+p2 0.04 0.015],'String',{'(a)'},'FitBoxToText','off','EdgeColor',[1 1 1],'FontWeight','bold');
% annotation('textbox',[p1 0.73+p2 0.04 0.015],'String',{'(b)'},'FitBoxToText','off','EdgeColor',[1 1 1],'FontWeight','bold');
% annotation('textbox',[p1 0.56+p2 0.04 0.015],'String',{'(c)'},'FitBoxToText','off','EdgeColor',[1 1 1],'FontWeight','bold');
% annotation('textbox',[p1 0.39+p2 0.04 0.015],'String',{'(d)'},'FitBoxToText','off','EdgeColor',[1 1 1],'FontWeight','bold');
% annotation('textbox',[p1 0.22+p2 0.04 0.015],'String',{'(e)'},'FitBoxToText','off','EdgeColor',[1 1 1],'FontWeight','bold');
% % annotation('textbox',[0.38  0.91+p2 0.04 0.015],'String',{'Tb'},'FitBoxToText','off','EdgeColor',[1 1 1],'FontWeight','bold');
% % annotation('textbox',[0.456 0.91+p2 0.04 0.015],'String',{'Tc'},'FitBoxToText','off','EdgeColor',[1 1 1],'FontWeight','bold');
% % annotation('line',[0.41  0.41 ],[0.88 0.106],'LineStyle',':','LineWidth',1.5);
% % annotation('line',[0.486 0.486],[0.88 0.106],'LineStyle',':','LineWidth',1.5);
%%
% set(gca,'XTickLabel',{'Aug-9','Aug-10','Aug-11','Aug-12','Aug-13','Aug-14','Aug-15'})
% xlabel({'date in year 2012'});
