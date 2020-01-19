--Action Card - Lock Draw
function c150000039.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c150000039.operation)
	c:RegisterEffect(e1)
	--become action card
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_BECOME_QUICK)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_REMOVE_TYPE)
	e3:SetValue(TYPE_QUICKPLAY)
	c:RegisterEffect(e3)
end
function c150000039.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(1-tp,150000039,0,0,0)
	local c=e:GetHandler()
	--cannot draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_DRAW)
	e1:SetTargetRange(1,0)
	e1:SetCondition(c150000039.con)
	Duel.RegisterEffect(e1,1-tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_DRAW_COUNT)
	e2:SetValue(0)
	Duel.RegisterEffect(e2,1-tp)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(150000039,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCondition(c150000039.con2)
	e3:SetOperation(function(e,tp)
		if Duel.DiscardHand(1-tp,c150000039.acfilter,1,1,REASON_EFFECT,nil)>0 then
			Duel.ResetFlagEffect(1-tp,150000039)
		end
	end)
	Duel.RegisterEffect(e3,1-tp)
	local e4=Effect.GlobalEffect()
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c150000039.con2)
	e4:SetOperation(function(e,tp)
		if Duel.SelectYesNo(1-tp,aux.Stringid(150000039,0))
			and Duel.DiscardHand(1-tp,c150000039.acfilter,1,1,REASON_EFFECT,nil)>0 then
			Duel.ResetFlagEffect(1-tp,150000039)
		end
	end)
	Duel.RegisterEffect(e4,1-tp)
end
function c150000039.con(e,tp)
	return Duel.GetFlagEffect(1-tp,150000039)>0
end
function c150000039.acfilter(c)
	return c:IsSetCard(0xac1) and c:IsAbleToGrave()
end
function c150000039.con2(e,tp)
	return Duel.GetFlagEffect(1-tp,150000039)>0 and Duel.IsExistingMatchingCard(c150000039.acfilter,1-tp,LOCATION_HAND,0,1,nil)
end