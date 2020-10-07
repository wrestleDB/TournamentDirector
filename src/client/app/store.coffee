import { createStore } from 'vuex'

store = createStore({
  state: ->
    return {
      user:
        username: "default@username.com"
        jwtToken: 'default_123_token'
      myEvents:
        listOfEvents: [{
          name: "Event KC_1 districts"
          date: "ISO Date.UTC Here tied to local time zone"
          location:
            locName: "K.T.C. Venue"
            lat: "latitude_coordinates"
            lng: "longitude_coordinates"
        }]

    }
})

export default store
