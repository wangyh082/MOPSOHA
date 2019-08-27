% binary mode sigmoid function
function y = activationFunction(x)
    y = 1./(1+exp(-2.0*x));
end