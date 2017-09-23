--Second Lecture
--Lunar's Card RIP Radio
function c515220652.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCost(c515220652.cost)
  e1:SetTarget(c515220652.target)
  e1:SetOperation(c515220652.activate)
  c:RegisterEffect(e1)
end

--Functions
--Activate
function c515220652.cost(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
  Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c515220652.filter(c,tp)
  return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsType(TYPE_CONTINUOUS)
end
function c515220652.target(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(c515220652.filter,tp,LOCATION_GRAVE,0,2,nil,tp) end
end
function c515220652.activate(e,tp,eg,ep,ev,re,r,rp)
  local ts=Duel.GetMatchingGroup(c515220652.filter,tp,LOCATION_GRAVE,0,nil,e,tp)
  if ts:GetCount()>=2 then
    Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(515220652,0))
    local tc=Duel.SelectMatchingCard(tp,c515220652.filter,tp,LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
    if Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true) then
      tc:IsRelateToEffect(e)
      local e1=Effect.CreateEffect(tc)
      e1:SetType(EFFECT_TYPE_SINGLE)
      e1:SetCode(EFFECT_DISABLE)
      e1:SetReset(RESET_EVENT+0x1fe0000)
      tc:RegisterEffect(e1)
      local e2=Effect.CreateEffect(tc)
      e2:SetType(EFFECT_TYPE_SINGLE)
      e2:SetCode(EFFECT_DISABLE_EFFECT)
      e2:SetReset(RESET_EVENT+0x1fe0000)
      tc:RegisterEffect(e2)
      local e3=Effect.CreateEffect(e:GetHandler())
            e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
            e3:SetCode(EVENT_PHASE+PHASE_END)
            e3:SetCountLimit(1)
            e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
            e3:SetLabelObject(tc)
            e3:SetCondition(c515220652.descon)
            e3:SetOperation(c515220652.desop)
            Duel.RegisterEffect(e3,tp)
    end
    
    Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(515220652,0))
    tc=Duel.SelectMatchingCard(tp,c515220652.filter,tp,LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
    if Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true) then
      tc:IsRelateToEffect(e)
      local e1=Effect.CreateEffect(tc)
      e1:SetType(EFFECT_TYPE_SINGLE)
      e1:SetCode(EFFECT_DISABLE)
      e1:SetReset(RESET_EVENT+0x1fe0000)
      tc:RegisterEffect(e1)
      local e2=Effect.CreateEffect(tc)
      e2:SetType(EFFECT_TYPE_SINGLE)
      e2:SetCode(EFFECT_DISABLE_EFFECT)
      e2:SetReset(RESET_EVENT+0x1fe0000)
      tc:RegisterEffect(e2)
      local e3=Effect.CreateEffect(e:GetHandler())
            e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
            e3:SetCode(EVENT_PHASE+PHASE_END)
            e3:SetCountLimit(1)
            e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
            e3:SetLabelObject(tc)
            e3:SetCondition(c515220652.descon)
            e3:SetOperation(c515220652.desop)
            Duel.RegisterEffect(e3,tp)
    end
    
    --  The following commented-out code is probably what allows something to
    --be truely "activated" by another card, akin to actually activating a
    --spell card from hand.
    --  However, when something like Tenki is "activated" by this card, its effect to search
    --does not trigger. Therefore, for now I'm removing the "activating" portion, since I
    --believe currently an exception would have to be made for every Continuous Spell card
    --to allow it to gain its activated effect.
    
    --local te=tc:GetActivateEffect()
    --local tep=tc:GetControler()
    --local cost=te:GetCost()
    --if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
  end
end
function c515220652.descon(e,tp,eg,ep,ev,re,r,rp)
    local tc=e:GetLabelObject()
    if tc:GetFlagEffect(515220652)~=0 then
      return true
    else
      e:Reset()
      return false
    end
end
function c515220652.desop(e,tp,eg,ep,ev,re,r,rp)
    local tc=e:GetLabelObject()
    Duel.Destroy(tc,REASON_EFFECT)
end
