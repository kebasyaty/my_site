import Vue from "vue";
import { VueReCaptcha } from "vue-recaptcha-v3";

export default {
  // Get language code
  ajaxGetLanguageCode({ commit }, payload) {
    return new Promise((resolve, reject) => {
      Vue.axios
        .get("/admin/language-code")
        .then((response) => {
          const data = response.data;
          if (data.msg_err.length > 0) {
            window.console.log(data.msg_err);
            reject(data.msg_err);
          } else {
            if (data.language_code.length > 0) {
              payload.i18n.locale = data.language_code;
            } else {
              payload.i18n.locale = payload.userLang;
            }
            commit("ckeditor/setLanguageCKEditor", payload.i18n.locale);
            resolve();
          }
        })
        .catch((error) => {
          window.console.log(error);
          reject(error);
        });
    });
  },
  // Get key for reCaptcha v3
  ajaxGetSiteKey({ state, commit }) {
    return new Promise((resolve, reject) => {
      if (state.siteKey.length === 0) {
        Vue.axios
          .get("/admin/recaptcha-site-key")
          .then((response) => {
            const data = response.data;
            if (data.msg_err.length > 0) {
              window.console.log(data.msg_err);
              reject(data.msg_err);
            } else if (data.site_key.length > 0) {
              Vue.use(VueReCaptcha, {
                siteKey: data.site_key,
                loaderOptions: {
                  useRecaptchaNet: true,
                  autoHideBadge: true,
                },
              });
              commit("setSiteKey", data.site_key);
              resolve();
            }
          })
          .catch((error) => {
            window.console.log(error);
            reject(error);
          });
      } else {
        resolve();
      }
    });
  },
};
