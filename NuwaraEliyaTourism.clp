;=====================================================
; EXPERT SYSTEM FOR NUWARA ELIYA TOURISM RECOMMENDATION
;=====================================================

(deftemplate tourist
   (slot name)
   (slot budget)
   (slot naturelove)
   (slot adventure)
   (slot relaxation)
   (slot spirituality)
   (slot duration)
   (slot weather)
   (slot setup))

(deftemplate recommendation
   (slot place)
   (slot reason))

;=====================================================
; USER INPUT
;=====================================================

(defrule get-user-input

   =>

   (printout t crlf)
   (printout t "====================================" crlf)
   (printout t " Nuwara Eliya Tourism Assistant Expert System" crlf)
   (printout t "====================================" crlf crlf)

   (printout t "Enter your name: ")
   (bind ?name (read))

   (printout t "Enter your budget (low/medium/high): ")
   (bind ?budget (read))

   (printout t "Are you a nature lover? (yes/no/neutral): ")
   (bind ?naturelove (read))

   (printout t "Interested in adventure? (yes/no/neutral): ")
   (bind ?adventure (read))

   (printout t "Prefer relaxation? (yes/no/neutral): ")
   (bind ?relaxation (read))

   (printout t "Interested in spirituality/culture? (yes/no/neutral): ")
   (bind ?spirituality (read))

   (printout t "Enter duration of stay (days): ")
   (bind ?duration (read))

   (printout t "Enter the current weather condition (cold/rainy/sunny): ")
   (bind ?weather (read))

   (printout t "What is your travel type? (solo/couple/group/family): ")
   (bind ?setup (read))

   (assert
      (tourist
         (name ?name)
         (budget ?budget)
         (naturelove ?naturelove)
         (adventure ?adventure)
         (relaxation ?relaxation)
         (spirituality ?spirituality)
         (duration ?duration)
         (weather ?weather)
         (setup ?setup)))
)

;=====================================================
; RECOMMENDATION RULES
;=====================================================

(defrule recommend-horton-plains

   (tourist
      (naturelove yes)
      (weather cold)
      (setup ?s&:(or (eq ?s group) (eq ?s solo))))

   =>

   (assert
      (recommendation
         (place "Horton Plains National Park")
         (reason "Beautiful hiking trails and cool climate")))
)

(defrule recommend-gregory-lake

   (tourist
      (relaxation yes)
      (weather sunny)
      (setup ?s&:(or (eq ?s couple) (eq ?s family))))

   =>

   (assert
      (recommendation
         (place "Gregory Lake")
         (reason "Ideal for boating and peaceful relaxation")))
)

(defrule recommend-tea-estate

   (tourist
      (spirituality yes)
      (naturelove yes)
      (weather cold))

   =>

   (assert
      (recommendation
         (place "Pedro Tea Estate")
         (reason "Experience Sri Lankan tea production")))
)

(defrule recommend-adventure

   (tourist
      (adventure yes)
      (weather cold)
      (setup ?s&:(or (eq ?s solo)
                     (eq ?s group)
                     (eq ?s couple))))

   =>

   (assert
      (recommendation
         (place "Single Tree Hill")
         (reason "Perfect for hiking and adventure")))
)

(defrule recommend-indoor

   (tourist
      (weather rainy))

   =>

   (assert
      (recommendation
         (place "Tea Factory Tour at Pedro Tea Estate")
         (reason "Indoor activity suitable during rainy weather")))
)
(defrule recommend-cool-weather

   (tourist
      (weather cold)
      (adventure ?a&:(or (eq ?a no) (eq ?a neutral)))
      (naturelove yes)
      (relaxation yes))

   =>

   (assert
      (recommendation
         (place "Victoria Park")
         (reason "Beautiful park with cool weather, ideal for relaxation")))
)
(defrule recommend-short-trip

   (tourist
      (duration ?d&:(<= ?d 2))
      (naturelove ?n&:(or (eq ?n yes) (eq ?n neutral)))
      (weather ?w&:(or (eq ?w sunny)
                       (eq ?w cold))))

   =>

   (assert
      (recommendation
         (place "Hakgala Botanical Garden")
         (reason "Best scenic destination for short stays")))
)

(defrule recommend-luxury

   (tourist
      (budget high))
      (relaxation yes)
      (weather ?w&:(or (eq ?w cold) (eq ?w rainy)))

   =>

   (assert
      (recommendation
         (place "Grand Hotel Nuwara Eliya")
         (reason "Premium luxury experience")))
)

(defrule recommend-budget

   (tourist
      (budget low)
      (relaxation yes)
      (weather ?w&:(or (eq ?w cold) (eq ?w sunny))))

   =>

   (assert
      (recommendation
         (place "Victoria Park")
         (reason "Affordable and relaxing attraction")))
)

(defrule recommend-romantic

   (tourist
      (setup couple)
      (naturelove yes)
      (adventure no))

   =>

   (assert
      (recommendation
         (place "Lover's Leap Waterfall")
         (reason "Romantic spot with beautiful views")))
)

(defrule recommend-family

   (tourist
      (setup family)
      (naturelove yes)
      (relaxation yes)
      (budget high))

   =>

   (assert
      (recommendation
         (place "Nuwara Eliya Golf Club")
         (reason "Family-friendly outdoor activity")))
)

(defrule recommend-solo

   (tourist
      (setup solo)
      (adventure ?a&:(or (eq ?a yes) (eq ?a neutral)))
      (naturelove yes))

   =>

   (assert
      (recommendation
         (place "Ramboda Falls")
         (reason "Great for solo travelers seeking adventure and nature")))
)
(defrule recommend-neutrals

   (tourist
      (setup ?s&:(or (eq ?s solo) (eq ?s couple) (eq ?s group) (eq ?s family)))
      (naturelove ?n&:(or (eq ?n yes) (eq ?n neutral)))
      (adventure ?a&:(or (eq ?a no) (eq ?a neutral)))
      (spirituality ?c&:(or (eq ?c yes) (eq ?c neutral)))
      (relaxation ?r&:(or (eq ?r yes) (eq ?r neutral)))
      (weather ?w&:(or (eq ?w cold) (eq ?w sunny))))


   =>

   (assert
      (recommendation
         (place  "Strawberry Farm"))
         (reason "Great option for travelers with neutral preferences.")))
)
(defrule recommend-culture

   (tourist
      (spirituality yes)
      (naturelove yes)
      (weather ?w&:(or (eq ?w cold)
                       (eq ?w rainy))))

   =>

   (assert
      (recommendation
         (place "Seetha Amman Temple")
         (reason "Cultural and spiritual experience")))
)

(defrule recommend-relaxation

   (tourist
      (relaxation yes)
      (naturelove ?n&:(or (eq ?n yes) (eq ?n neutral)))
      (weather ?w&:(or (eq ?w cold) (eq ?w sunny))))

   =>

   (assert
      (recommendation
         (place "Victoria Park")
         (reason "Beautiful park with cool weather, ideal for relaxation")))
)

(defrule recommend-postoffice

   (tourist
      (naturelove yes)
      (weather cold)
      (setup ?s&:(or (eq ?s solo)
                     (eq ?s group)
                     (eq ?s couple))))

   =>

   (assert
      (recommendation
         (place "Nuwara Eliya Post Office")
         (reason "Iconic colonial architecture and scenic surroundings")))
)

(defrule recommend-boat-ride

   (tourist
      (naturelove yes)
      (adventure yes)
      (weather sunny)
      (setup ?s&:(or (eq ?s couple)
                     (eq ?s family))))

   =>

   (assert
      (recommendation
         (place "Gregory Lake Boat Ride")
         (reason "Enjoy boating with beautiful lake views")))
)
(defrule recommend-moon-plains

   (tourist
      (naturelove ?n&:(or (eq ?n yes) (eq ?n neutral)))
      (weather ?w&:(or (eq ?w cold) (eq ?w sunny))))

   =>

   (assert
      (recommendation
         (place "Moon Plains Viewpoint")
         (reason "Scenic location to view the unique landscape of Mountains and plains")))
)
(defrule recommend-waterfalls

   (tourist
      (naturelove yes)
      (adventure yes)
      (weather cold)
      (setup ?s&:(or (eq ?s solo)
                     (eq ?s group)
                     (eq ?s couple))))

   =>

   (assert
      (recommendation
         (place "Bomuru Ella Falls")
         (reason "Scenic waterfall with hiking opportunities")))
)

(defrule recommend-strawberry-farm

   (tourist
      (naturelove yes)
      (weather cold))

   =>

   (assert
      (recommendation
         (place "Strawberry Farm")
         (reason "Great for picking fresh strawberries")))
)

(defrule recommend-moon-plains

   (tourist
      (budget medium)
      (relaxation yes)
      (weather sunny))

   =>

   (assert
      (recommendation
         (place "Moon Plains camping")
         (reason "Relaxing scenic experience")))
)
(defrule recommend-golf

   (tourist
      (setup ?s&:(or (eq ?s family) (eq ?s group)))
      (naturelove ?n&:(or (eq ?n yes) (eq ?n neutral)))
      (relaxation ?r&:(or (eq ?r yes) (eq ?r neutral)))
      (budget high))

   =>

   (assert
      (recommendation
         (place "Nuwara Eliya Golf Club")
         (reason "Family-friendly outdoor activity in Nuwara Eliya with a premium experience of golfing amidst beautiful surroundings.") ))
)
(defrule recommend-horse-riding

   (tourist
      (adventure yes)
      (weather sunny)
      (setup ?s&:(or (eq ?s solo)
                     (eq ?s couple)
                     (eq ?s group))))

   =>

   (assert
      (recommendation
         (place "Horse Riding at Nuwara Eliya")
         (reason "Enjoy horse riding in a beautiful environment at the Nuwara Eliya Racecourse and its surroundings")))
)

(defrule recommend-highbudget-relaxation

   (tourist
      (naturelove yes)
      (weather cold)
      (setup ?s&:(or (eq ?s family)
                     (eq ?s couple))))

   =>

   (assert
      (recommendation
         (place "Little England Cottage")
         (reason "Relaxing stay with beautiful surroundings. Ideal place for taking pictures and enjoying the cool weather.")))
)

(defrule recommend-farm-visit

   (tourist
      (naturelove yes)
      (adventure yes)
      (weather sunny)
      (setup ?s&:(or (eq ?s solo)
                     (eq ?s group)
                     (eq ?s family))))

   =>

   (assert
      (recommendation
         (place "Ambewela Farm")
         (reason "Experience farm life and fresh dairy products. Great for nature lovers and knowledge seekers.")))
)

(defrule recommend-cable-car

   (tourist
      (adventure yes)
      (weather cold)
      (setup ?s&:(or (eq ?s group)
                     (eq ?s couple))))

   =>

   (assert
      (recommendation
         (place "Ramboda Falls Cable Car")
         (reason "Stunning landscape views from above over the ramboda falls and surroundings.")))
)

(defrule recommend-singletree

   (tourist
      (naturelove yes)
      (adventure yes)
      (weather ?w&:(or (eq ?w cold) (eq ?w sunny)))
      
      (setup ?s&:(or (eq ?s solo)
                     (eq ?s group)
                     (eq ?s family))))

   =>

   (assert
      (recommendation
         (place "Nuwara Eliya Planetarium")
         (reason "Educational and fun experience for nature lovers and adventure seekers during rainy weather.")))
)

;=====================================================
; DISPLAY OUTPUT
;=====================================================

(defrule display-recommendation

   ?r <- (recommendation
            (place ?p)
            (reason ?rson))

   =>

   (printout t crlf)
   (printout t "----------------------------------" crlf)
   (printout t "Recommended Place: " ?p crlf)
   (printout t "Reason: " ?rson crlf)
   (printout t "----------------------------------" crlf)
)


(deftemplate hotel-preference
   (slot budget)
   (slot distance)
   (slot ambience)
   (slot view))

(deftemplate hotels
   (slot name)
   (slot reason))
(defrule input-hotels

   =>

   (printout t crlf)
   (printout t "====================================" crlf)
   (printout t " Hotel Recommendation Assistant " crlf)
   (printout t "====================================" crlf crlf)

   (printout t "Enter your budget for accommodation (low/medium/high): ")
   (bind ?budget (read))

   (printout t "Preferred distance from city center? (city/outer): ")
   (bind ?distance (read))

   (printout t "Preferred ambience? (cozy/luxury/nature): ")
   (bind ?ambience (read))

   (printout t "Preferred view? (mountain/lake/garden/city): ")
   (bind ?view (read))

   (assert
      (hotel-preference
         (budget ?budget)
         (distance ?distance)
         (ambience ?ambience)
         (view ?view)))
)

(defrule recommend-hotel1

   (hotel-preference
      (budget ?b&:(or (eq ?b low) (eq ?b medium)))
      (distance city)
      (ambience cozy))

   =>

   (assert
      (hotels
         (name "Hill Club")
         (reason "Cozy hotel with a great location near the city center")))
)
(defrule recommend-hotel2

   (hotel-preference
      (budget high)
      (distance outer)
      (ambience luxury)
      (view mountain))

   =>

   (assert
      (hotels
         (name "Grand Hotel Nuwara Eliya")
         (reason "Luxury hotel with stunning mountain views")))
)
(defrule recommend-hotel3

   (hotel-preference
      (budget low)
      (distance outer)
      (ambience cozy)
      (view lake))

   =>

   (assert
      (hotels
         (name "National Holiday Resort, Nuwara Eliya")
         (reason "Affordable cozy hotel with beautiful lake views and garden surroundings")))
)
(defrule recommend-hotel4

   (hotel-preference
      (budget medium)
      (distance city)
      (ambience cozy)
      (view garden))

   =>

   (assert
      (hotels
         (name "Araliya Green Hills Hotel, Nuwara Eliya")
         (reason "A scenic hotel with a cozy atmosphere and garden views")))
)
(defrule recommend-hotel5

   (hotel-preference
      (budget medium)
      (distance city)
      (ambience luxury)
      (view lake))

   =>

   (assert
      (hotels
         (name "Serenus Boutique Villa, Nuwara Eliya")
         (reason "Luxury hotel with a great location and lake views")))
)
(defrule recommend-hotel6

   (hotel-preference
      (budget medium)
      (distance outer)
      (ambience nature)
      (view mountain))

   =>

   (assert
      (hotels
         (name "La Luna Cabins, Moon Plains")
         (reason "A nature-inspired hotel with a great location and mountain views")))
)
(defrule recommend-hotel7

   (hotel-preference
      (budget high)
      (distance outer)
      (ambience luxury)
      (view mountain))

   =>

   (assert
      (hotels
         (name "Blackpool Resort & Spa, Nuwara Eliya")
         (reason "Luxury hotel with a great location and mountain views")))
)
(defrule recommend-hotel8

   (hotel-preference
      (budget low)
      (distance city)
      (ambience cozy)
      (view city))

   =>

   (assert
      (hotels
         (name "Hotel Dreamland, Nuwara Eliya")
         (reason "Affordable hotel with a cozy atmosphere and city views")))
)
(defrule recommend-hotel9

   (hotel-preference
      (budget medium)
      (distance outer)
      (ambience cozy)
      (view garden))

   =>

   (assert
      (hotels
         (name "The Hill Club, Nuwara Eliya")
         (reason "A cozy hotel with a great location and garden views")))
)
(defrule recommend-hotel10

   (hotel-preference
      (budget medium)
      (distance outer)
      (ambience luxury)
      (view garden))

   =>

   (assert
      (hotels
         (name "Jetwing St.Andrews, Nuwara Eliya")
         (reason "Luxury hotel with a great location and garden views")))
)

(defrule display-hotel-recommendation

   ?r <- (hotels
            (name ?p)
            (reason ?rson))

   =>

   (printout t crlf)
   (printout t "----------------------------------" crlf)
   (printout t "Recommended Hotel: " ?p crlf)
   (printout t "Reason: " ?rson crlf)
   (printout t "----------------------------------" crlf)
)

(deftemplate restaurant-preference
   (slot budget)
   (slot cuisine)
   (slot ambience)
   (slot dietary))
(deftemplate restaurants
   (slot name)
   (slot reason))
(defrule input-restaurants
   
   =>

   (printout t crlf)
   (printout t "====================================" crlf)
   (printout t " Restaurant Recommendation Assistant " crlf)
   (printout t "====================================" crlf crlf)

   (printout t "Enter your budget for dining (low/medium/high): ")
   (bind ?budget (read))

   (printout t "Preferred cuisine? (local/international/indian): ")
   (bind ?cuisine (read))

   (printout t "Preferred ambience? (casual/fine-dining/romantic): ")
   (bind ?ambience (read))

   (printout t "Any dietary restrictions? (none/vegetarian/vegan/gluten-free): ")
   (bind ?dietary (read))

   (assert
      (restaurant-preference
         (budget ?budget)
         (cuisine ?cuisine)
         (ambience ?ambience)
         (dietary ?dietary)))
)
(defrule recommend-restaurant1

   (restaurant-preference
      (budget low)
      (cuisine local)
      (ambience casual))

   =>

   (assert
      (restaurants
         (name "Grand Indian")
         (reason "Affordable local cuisine in a casual setting")))
)
(defrule recommend-restaurant2

   (restaurant-preference
      (budget high)
      (cuisine international)
      (ambience fine-dining)
      (dietary none))

   =>

   (assert
      (restaurants
         (name "The Hill Club Restaurant")
         (reason "Fine dining experience with a variety of international dishes")))
)
(defrule recommend-restaurant3

   (restaurant-preference
      (budget medium)
      (cuisine vegetarian)
      (ambience casual))

   =>

   (assert
      (restaurants
         (name "Cafe Chill")
         (reason "Casual dining with a good selection of vegetarian options")))
)
(defrule recommend-restaurant4

   (restaurant-preference
      (budget medium)
      (cuisine local)
      (ambience romantic))

   =>

   (assert
      (restaurants
         (name "The Grand Hotel Nuwara Eliya - The Verandah")
         (reason "Romantic setting with delicious local cuisine")))
)
(defrule recommend-restaurant5

   (restaurant-preference
      (budget low)
      (cuisine international)
      (ambience casual))

   =>

   (assert
      (restaurants
         (name "Salmiya Italian Restaurant")
         (reason "Affordable international cuisine in a casual atmosphere")))
)
(defrule recommend-restaurant6

   (restaurant-preference
      (budget high)
      (cuisine international)
      (ambience fine-dining)
      (dietary vegetarian))

   =>

   (assert
      (restaurants
         (name "The Grand Hotel Nuwara Eliya - The Verandah")
         (reason "Fine dining experience with excellent vegetarian options")))
)
(defrule recommend-restaurant7

   (restaurant-preference
      (budget low)
      (cuisine indian)
      (ambience casual)
      (dietary vegetarian))

   =>

   (assert
      (restaurants
         (name "Ambaals Pure Veg, Nuwara Eliya")
         (reason "Casual budget-friendly vegetarian cuisine with authentic indian flavors")))
)

(defrule recommend-restaurant8

   (restaurant-preference
      (budget medium)
      (cuisine local)
      (ambience romantic))

   =>

   (assert
      (restaurants
         (name "The Kitchen Restaurant")
         (reason "Romantic fine dining experience with a variety of local fusion dishes")))
)

(defrule display-restaurant-recommendation

   ?r <- (restaurants
            (name ?p)
            (reason ?rson))

   =>

   (printout t crlf)
   (printout t "----------------------------------" crlf)
   (printout t "Recommended Restaurant: " ?p crlf)
   (printout t "Reason: " ?rson crlf)
   (printout t "----------------------------------" crlf)
)
