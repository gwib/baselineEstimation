pts = readtable('ransac14.txt','ReadVariableNames',false);
ptsArray = table2array(pts(:,1:2));

figure()
axis equal
scatter(ptsArray(:,1), ptsArray(:,2));

% estimate circle a priori to find an a priori standard deviation
[initZ, initR] = fitcircle(ptsArray);
hold on
viscircles(transpose(initZ),initR);

numRansacIterations = 20;

% total number of points
numPoints = length(ptsArray);

% we would like to have 80 percent fit
inlierPerc = 0.99;

%alternatively: expected noise to define threshold
%TODO: how to estimate expected noise?
% calculate estimated standard deviation based on init circle

% Calculating standard deviation to determine max distance for inlier
% definition
sse = 0;
for i=1:numPoints
    sse = sse + distToCircle(ptsArray(i,1),ptsArray(i,2), initZ(1), initZ(2),initR)^2;
end
sd = sqrt(sse/(numPoints-1));
maxDist= sd/4;

% threshold: number of points that are inliers
t = floor(numPoints*inlierPerc);
% max iterations in RANSAC
maxIters = 250;

% initialise values before loop
numInliers = 0;
maxNumInliers = 0;
bestZ = nan;
bestR = nan;

for i=1:numRansacIterations
    %fprintf('----------------------------\n');
    j=0;
    % find random initial subset of points
    % need min 3 points to estimate circle parameters
    randomIndex = randperm(numPoints, 3);
    randomPoints = ptsArray(randomIndex,:);
    % initialize inliers with random points
    estPoints = randomPoints;
    while (j<=maxIters && numInliers < t)
        j = j + 1;
        % estimate new circleParam
        [newZ, newR] = fitcircle(estPoints, 'linear');
        % calculate number of inliers for that circle
        numInliers=0;
        inliers = zeros(numPoints,2);
        % calculate distance for each point and check if it is <2sigma
        for k=1:numPoints
            if distToCircle(ptsArray(k,1),ptsArray(k,2), ...
                    newZ(1), newZ(2),newR) < maxDist
                    numInliers = numInliers +1;
                    inliers(numInliers,:) = ptsArray(k,:);
            end
        end
        % check if this circle contains more inliers than the previously
        % estiamted circle
        if numInliers > maxNumInliers
            maxNumInliers = numInliers;
            bestZ = newZ;
            bestR = newR;
            maxInliersV = inliers(1:numInliers,:);
            fprintf('New best circle estimate found in iteration %i.%i:\n', i, j);
            fprintf('Number of inliers: %i.\n', maxNumInliers);
            fprintf('New circle centre: %d %d \n', bestZ);
            fprintf('New circle radius: %d \n\n', bestR);
            %fprintf('---------------------------------------\n')
            % all new inliers are used for estimating the new circle
            estPoints = maxInliersV;
        end
    end
end

hold on
scatter(maxInliersV(:,1), maxInliersV(:,2), 'g');

hold on
viscircles(transpose(bestZ),bestR, 'Color','g');

