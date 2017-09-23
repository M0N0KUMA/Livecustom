--Portal of the Sacred Beasts
function c515220651.initial_effect(c)
   local e1=Effect.CreateEffect(c)
   e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
   e1:SetType(EFFECT_TYPE_ACTIVATE)
   e1:SetCode(EVENT_FREE_CHAIN)
   e1:SetCost(c515220651.cost)
   e1:SetCountLimit(1,515220651+EFFECT_COUNT_CODE_OATH)
   e1:SetTarget(c515220651.target)
   e1:SetOperation(c515220651.activate)
   c:RegisterEffect(e1)
end 
--[[filters if your card is a continuous spell and if you can send it to grave while you have targets for search]]
function c515220651.cfilter(c, tp)
  return (c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsType(TYPE_CONTINUOUS)) and c:IsAbleToGraveAsCost() 
  and Duel.IsExistingMatchingCard(c515220651.filter,tp,LOCATION_DECK,0,1,nil,tp)
end
--you got to pay your cost... fam
function c515220651.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c515220651.cfilter,tp,LOCATION_DECK,0,1,nil,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g1=Duel.SelectMatchingCard(tp,c515220651.cfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
    local g2=Duel.SelectMatchingCard(tp,c515220651.cfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
    Duel.SendtoGrave(g1,REASON_COST)
    Duel.SendtoGrave(g2,REASON_COST)
end
--filter your 3 gods that you can search by codeNumber
function c515220651.filter(c)
  return c:IsCode(69890967,32491822,06007213) and c:IsAbleToHand()
end

function c515220651.target(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c515220651.activate(e,tp,eg,ep,ev,re,r,rp,chk)
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
  local g=Duel.SelectMatchingCard(tp,c515220651.filter,tp,LOCATION_DECK,0,1,1,nil)
  if g:GetCount()>0 then
    Duel.SendtoHand(g,nil,REASON_EFFECT)
    Duel.ConfirmCards(1-tp,g)
  end
end
