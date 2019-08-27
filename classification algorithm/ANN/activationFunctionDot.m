% 1st derivative function of activation function
function y_dot = activationFunctionDot(x)
    y = activationFunction(x);
    y_dot = 2.0 * y .* (1 - y);
end