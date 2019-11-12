pts = readtable('ransac14.txt','ReadVariableNames',false);
ptsArray = table2array(pts(:,1:2));

figure()
axis equal
scatter(ptsArray(:,1), ptsArray(:,2));

% estimate circle a priori to find an a priori standard deviation
[initZ, initR] = fitcircle(ptsArray);
%hold on
%viscircles(transpose(initZ),initR);

numRansacIterations = 30;

% total number of points
numPoints = length(ptsArray);

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

% max iterations within RANSAC
maxIters = 150;

% initialise values before loop
numInliers = 0;
maxNumInliers = 0;
bestZ = nan;
bestR = nan;

numInliersVector = zeros(1000);

% RANSAC Iterations
for i=1:length(numInliersVector)
    %fprintf('----------------------------\n');
    j=0;
    % find random initial subset of points
    % need min 3 points to estimate circle parameters
    randomIndex = randperm(numPoints, 3);
    randomPoints = ptsArray(randomIndex,:);
    % initialize inliers with random points
    estPoints = randomPoints;
    
    % RANSAC Subiterations
    numInliersVectorSub = zeros(maxIters);
    while j<=maxIters %&& numInliers < t)
        j = j + 1;
        maxInliersSub = zeros(maxIters);
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
            maxInliersV = inliers(1:numInliers,:);
            bestZ = newZ;
            bestR = newR;
            fprintf('New best circle estimate found in iteration %i.%i:\n', i, j);
            fprintf('Number of inliers: %i.\n', maxNumInliers);
            fprintf('New circle centre: %d %d \n', bestZ);
            fprintf('New circle radius: %d \n\n', bestR);
            %fprintf('---------------------------------------\n')
            % all new inliers are used for estimating the new circle
            estPoints = maxInliersV;
        end
        numInliersVectorSub(j) = maxNumInliers;
        if j>3
            if numInliersVectorSub(j) == numInliersVectorSub(j-3) % converging number of inliers in the last three subiterations
                numInliersVector(i) = maxNumInliers;
                break;
            end
        end
    end
    if i>15
        if numInliersVector(i) == numInliersVector(i-15) % converging number of inliers in the last three iterations
            break;
        end
    else
        continue;
    end
    
end


hold on
scatter(maxInliersV(:,1), maxInliersV(:,2), 'g');

hold on
viscircles(transpose(bestZ),bestR, 'Color','g');

fprintf('-------------------------------\n');
fprintf('-------------------------------\n');
fprintf('Final Result:\n')
fprintf('Number of inliers: %i.\n', maxNumInliers);
fprintf('New circle centre: %d %d \n', bestZ);
fprintf('New circle radius: %d \n\n', bestR);
fprintf('-------------------------------\n');
fprintf('Number of total RANSAC iterations: %i\n', i);