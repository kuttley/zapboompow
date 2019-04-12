const axios = require('axios');
import auth from '@/auth';

export default {
    data() {
        return {
            backend: axios.create({
                baseURL: `${process.env.VUE_APP_REMOTE_API}`,
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + auth.getToken()
                }
            }),
            
            marvel: axios.create({
                baseURL: 'https://gateway.marvel.com:443/v1/public/',
                headers: {
                    'Content-Type': 'application/json',
                },
                params: {
                    ts:`${process.env.VUE_APP_MARVEL_API_TS}`,
                    apikey:`${process.env.VUE_APP_MARVEL_API_KEY}`,
                    hash:`${process.env.VUE_APP_MARVEL_API_HASH}`
                }
            })
        }
    },

    
    post(url, data) {
        return this.data().backend.post(url, data)
            .catch((err) => console.log(err));
    },
    get(url) {
        return this.data().backend.get(url);
    },
    marvelGet(url) {
        return this.data().marvel.get(url);
    }
}