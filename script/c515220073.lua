--Phantom Knights' Hallowed Grounds
function c515220073.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK))
	e2:SetValue(300)
	c:RegisterEffect(e2)
	--defup
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--Send to Grave
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOGRAVE)
	e4:SetDescription(aux.Stringid(1151281,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetLabel(3)
	e4:SetCountLimit(1,515220073)
	e4:SetCondition(c515220073.effcon)
	e4:SetTarget(c515220073.tg1)
	e4:SetOperation(c515220073.op1)
	c:RegisterEffect(e4)
	--Back to hand
	local e5=e4:Clone()
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetDescription(aux.Stringid(41546,1))
	e5:SetLabel(5)
	e5:SetTarget(c515220073.tg2)
	e5:SetOperation(c515220073.op2)
	c:RegisterEffect(e5)
	--Attach
	local e6=e4:Clone()
	e6:SetCategory(0)
	e6:SetDescription(aux.Stringid(12744567,2))
	e6:SetLabel(7)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetTarget(c515220073.tg3)
	e6:SetOperation(c515220073.op3)
	c:RegisterEffect(e6)
	--To Grave
	local e7=e6:Clone()
	e7:SetCategory(CATEGORY_TOGRAVE)
	e7:SetDescription(aux.Stringid(6343408,3))
	e7:SetLabel(9)
	e7:SetTarget(c515220073.tg4)
	e7:SetOperation(c515220073.op4)
	c:RegisterEffect(e7)
end
function c515220073.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xdb)
end
function c515220073.effcon(e)
	return Duel.GetMatchingGroup(c515220073.cfilter,e:GetHandlerPlayer(),LOCATION_GRAVE+LOCATION_REMOVED,0,nil):GetClassCount(Card.GetCode)>=e:GetLabel()
end
function c515220073.tgfilter1(c)
	return c:IsSetCard(0xdb) and c:IsAbleToGrave()
end
function c515220073.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c515220073.tgfilter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c515220073.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c515220073.tgfilter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c515220073.thfilter(c)
	return c:IsSetCard(0x10db) and c:IsAbleToHand() and ((c:IsLocation(LOCATION_GRAVE) and not c:IsCode(515220073)) or (c:IsLocation(LOCATION_EXTRA) and c:IsFaceup() and c:IsType(TYPE_PENDULUM)))
end
function c515220073.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c515220073.thfilter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
end
function c515220073.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c515220073.thfilter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c515220073.xyzfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_DARK)
		and Duel.IsExistingMatchingCard(c515220073.matfilter,tp,LOCATION_REMOVED,0,1,c)
end
function c515220073.matfilter(c)
	return c:IsSetCard(0xdb)
end
function c515220073.tg3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c515220073.xyzfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c515220073.xyzfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c515220073.xyzfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c515220073.op3(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g=Duel.SelectMatchingCard(tp,c515220073.matfilter,tp,LOCATION_REMOVED,0,1,1,tc)
		if g:GetCount()>0 then
			local mg=g:GetFirst():GetOverlayGroup()
			if mg:GetCount()>0 then
				Duel.SendtoGrave(mg,REASON_RULE)
			end
			Duel.Overlay(tc,g)
		end
	end
end
function c515220073.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0xdb)
end
function c515220073.tg4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c515220073.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c515220073.filter2,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c515220073.filter2,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c515220073.op4(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_RETURN)
	end
end
