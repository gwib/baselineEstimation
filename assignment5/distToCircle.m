function [dist] = distToCircle(x,y, x0, y0,r)
%DISTANCETOCIRCLE Summary of this function goes here
%   in: circle params and point coordinates; out: distance of point to
%   circle
    dist = abs(sqrt((x-x0)^2+(y-y0)^2)-r);
end

