% Mutate Operator

function newParticle = Mutate(particle, pm, VarMin, VarMax)

	nVar = numel(particle);
	wichdim = randi([1 nVar]);

	mutrange = (VarMax(wichdim) - VarMin(wichdim))*pm;

	lb = particle(wichdim) - mutrange;
	ub = particle(wichdim) + mutrange;

	if lb < VarMin(wichdim)
		lb = VarMin(wichdim);
	end
	if ub > VarMax(wichdim);
		ub = VarMax(wichdim);
	end

	newParticle = particle;
	newParticle(wichdim) = unifrnd(lb, ub);

end
