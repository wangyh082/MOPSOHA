classdef two_level_decision_tree
  
  properties (SetAccess = private, GetAccess = private)
    dimension % feature number of the dimension * sign (3 values)
    threshold % threshold value (3 values)
    labels    % 2x2 matrix
    Idx % value precalculated for speed ({obj.Thr, obj.Idx] = sort(X,1, 'ascend'))
    Thr % value precalculated for speed ([obj.Thr, obj.Idx] = sort(X,1, 'ascend'))
    nTries = 5; % number of root node candidates to test in exhaustive search
  end % properties
  
  methods ( Access = public )
    
    %% ===========================================================
    function obj = two_level_decision_tree(nTries)
      if nargin>0
        obj.nTries = nTries;
      end
    end
    
    %% ===========================================================
    function obj = preprocess_train_data(obj,X)
      % precompute some time consuming steps
      if isempty(obj.Thr)
        [obj.Thr, obj.Idx] = sort(X,1, 'ascend');
      end
    end
    
    %% ===========================================================
    function obj = train(obj, X,y,w)
      if isempty(obj.Thr)
        % optional parameter to precompute some time consuming steps
        [obj.Thr, obj.Idx] = sort(X,1, 'ascend');
      end
      assert(size(X,1)==numel(y), 'Number of Rows in X has to be the same as number of elements in y.')
      
      %% compute error and sizes of best split for each dimension
      w = w/sum(w);
      Thr   = zeros(1,size(X,2)); %#ok<*PROPLC>
      frac  = zeros(1,size(X,2));
      error = zeros(1,size(X,2));
      [nSamp, nFeat] = size(X);
      for iFeat = 1:nFeat
        x = X(:,iFeat);
        [Thr(iFeat), ~, ~, error(iFeat)] = train_stump_N(x, y, w, obj.Thr(:,iFeat), obj.Idx(:,iFeat));
        n = nnz(x>Thr(iFeat))/nSamp; % fraction of elements in one of the splits
        frac(iFeat) = max(n, 1-n);   % fraction of elements in bigger of the splits
      end
      
      %% 
      %[~,idx] = sort(frac.*error); % favor minimal error and equal number of samples in 2 parts
      [~,idx] = sort(error);       % favor minimal error only
      min_error = 1;
      lab = zeros(2,2);
      %k = 0;
      for i = 1:min(obj.nTries, nFeat) % test 5 "best"  features
        iFeat = idx(i);
        x = X(:,iFeat);
        thr(1) = Thr(iFeat);
        dim(1) = iFeat;
        msk = (x>thr(1));
        [thr(2), dim(2), lab(:,1), error1] = train_stump_N(X, y, w, obj.Thr, obj.Idx,  msk);
        [thr(3), dim(3), lab(:,2), error2] = train_stump_N(X, y, w, obj.Thr, obj.Idx, ~msk);
        error = error1+error2;
        if(error < min_error)
          min_error = error;
          obj.threshold = thr;
          obj.dimension = dim;
          obj.labels    = lab;
          %k = i;
        end
      end
      %fprintf('Chosen one is %i\n', k);
      obj.Thr = [];               % no longer needed large data
      obj.Idx = [];               % no longer needed large data
    end % train
    
    
    %% ===========================================================
    function y = predict(obj, X)
      % INPUT:
      %  X - (N x D) test data set, each of N rows is a testing
      %      sample in the D dimensional feature space.
      % OUTPUT:
      %  y - (N X 1) predicted label. Will be 1, 2 or NaN
      d   = obj.dimension;
      lab = obj.labels(:);
      msk     =  X(:   ,d(1))>obj.threshold(1);
      y( msk) = lab((X( msk,d(2))>obj.threshold(2)) + 1);
      y(~msk) = lab((X(~msk,d(3))>obj.threshold(3)) + 3);
      y(any(isnan(X(:,d)),2)) = NaN;
      y = y(:);
    end % predict
       
    %% ===========================================================
    function str = print(obj)
      % print info about the classifier
      d = obj.dimension;
      t = obj.threshold;
      l = obj.labels(:);
      str = sprintf('X(%3i)>%7.3f ? (X(%3i)>%7.3f ? %i : %i) : (X(%3i)>%7.3f ? %i : %i)' , ...
        d(1), t(1), d(2), t(2), l(1), l(2), d(3), t(3), l(3), l(4));
    end % print
    
    %% ===========================================================
    function [str, dimension, header] = export_model(obj)
      dimension = obj.dimension;
      str = sprintf('%i,%i,%i,%e,%e,%e,%i,%i,%i,%i', ...
        obj.dimension(1), obj.dimension(2), obj.dimension(3), ...
        obj.threshold(1), obj.threshold(2), obj.threshold(3), ...
        obj.labels(1), obj.labels(2), obj.labels(3), obj.labels(4) );
      header = ['dimension1, dimension2, dimension3, ', ...
      'threshold1, threshold2, threshold3,  ', ...
      'label 1, label 2, label 3, label 4'];
    end
    
    %% ===========================================================
    function obj = import_model(obj,str)
      v = sscanf(str, '%i,%i,%i,%e,%e,%e,%i,%i,%i,%i');
      obj.dimension = v(1:3);
      obj.threshold = v(4:6);
      obj.labels    = v(7:10);
      obj.Thr = [];
      obj.Idx = [];
    end
    
    %% ===========================================================
    function t = same(obj1,obj2)
      % Compare 2 objects to see if they ar the same
      t = (obj1.dimension == obj2.dimension) && ...
          (obj1.threshold == obj2.threshold) && ...
          all(obj1.labels == obj2.labels);
    end % same
  end % methods
end % classdef

