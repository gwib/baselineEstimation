geoidHeights2008a = [
    39.664;
    39.5900;
    39.5910;
    39.5620;
    39.4470;
    39.6430;
    39.7270;
    39.5670;
    39.6150;
    39.5640;
    39.5480;
    39.5670;
    40.0180;
    40.1390;
    39.7320;
    39.8820;
    39.3270;
    39.3780;
    39.5460;
    39.2010;
    39.5710
    ];

diffModels = geoidHeightsModel1 - geoidHeights2008a;

I = eye(21);

sd_0 = sqrt((transpose(diffModels)*I*diffModels)/(n-e));
