"use strict";(self["webpackChunkadmin_panel"]=self["webpackChunkadmin_panel"]||[]).push([[148],{4039:function(t,e,s){s.r(e),s.d(e,{default:function(){return M}});var i=s(3642),a=s(7624),r=s(8719),o=s(8499),n=s(2891),l=s(7425),c=s(1750),u=s(7103),h=s(8436),d=(s(4114),s(9216)),g=s(6579),p=s(9738),m=s(5368),v=s(3596),f=s(444),b=(0,f.A)(p.A,(0,m.A)({onVisible:["init"]}),v.A).extend({name:"v-pagination",directives:{Resize:g.A},props:{circle:Boolean,disabled:Boolean,navigationColor:String,navigationTextColor:String,length:{type:Number,default:0,validator:t=>t%1===0},nextIcon:{type:String,default:"$next"},prevIcon:{type:String,default:"$prev"},totalVisible:[Number,String],value:{type:Number,default:0},pageAriaLabel:{type:String,default:"$vuetify.pagination.ariaLabel.page"},currentPageAriaLabel:{type:String,default:"$vuetify.pagination.ariaLabel.currentPage"},previousAriaLabel:{type:String,default:"$vuetify.pagination.ariaLabel.previous"},nextAriaLabel:{type:String,default:"$vuetify.pagination.ariaLabel.next"},wrapperAriaLabel:{type:String,default:"$vuetify.pagination.ariaLabel.wrapper"}},data(){return{maxButtons:0,selected:null}},computed:{classes(){return{"v-pagination":!0,"v-pagination--circle":this.circle,"v-pagination--disabled":this.disabled,...this.themeClasses}},items(){const t=parseInt(this.totalVisible,10);if(0===t||isNaN(this.length)||this.length>Number.MAX_SAFE_INTEGER)return[];const e=Math.min(Math.max(0,t)||this.length,Math.max(0,this.maxButtons)||this.length,this.length);if(this.length<=e)return this.range(1,this.length);const s=e%2===0?1:0,i=Math.floor(e/2),a=this.length-i+1+s;if(this.value>i&&this.value<a){const t=1,e=this.length,a=this.value-i+2,r=this.value+i-2-s,o=a-1===t+1?2:"...",n=r+1===e-1?r+1:"...";return[1,o,...this.range(a,r),n,this.length]}if(this.value===i){const t=this.value+i-1-s;return[...this.range(1,t),"...",this.length]}if(this.value===a){const t=this.value-i+1;return[1,"...",...this.range(t,this.length)]}return[...this.range(1,i),"...",...this.range(a,this.length)]}},watch:{value(){this.init()}},beforeMount(){this.init()},methods:{init(){this.selected=null,this.onResize(),this.$nextTick(this.onResize),setTimeout((()=>this.selected=this.value),100)},onResize(){const t=this.$el&&this.$el.parentElement?this.$el.parentElement.clientWidth:window.innerWidth;this.maxButtons=Math.floor((t-96)/42)},next(t){t.preventDefault(),this.$emit("input",this.value+1),this.$emit("next")},previous(t){t.preventDefault(),this.$emit("input",this.value-1),this.$emit("previous")},range(t,e){const s=[];t=t>0?t:1;for(let i=t;i<=e;i++)s.push(i);return s},genIcon(t,e,s,i,a){return t("li",[t("button",this.setBackgroundColor(this.navigationColor,{staticClass:"v-pagination__navigation",class:{"v-pagination__navigation--disabled":s},attrs:{disabled:s,type:"button","aria-label":a},on:s?{}:{click:i}}),[t(d.A,{props:{color:this.navigationTextColor}},[e])])])},genItem(t,e){const s=e===this.value&&(this.color||"primary"),i=e===this.value,a=i?this.currentPageAriaLabel:this.pageAriaLabel;return t("button",this.setBackgroundColor(s,{staticClass:"v-pagination__item",class:{"v-pagination__item--active":e===this.value},attrs:{type:"button","aria-current":i,"aria-label":this.$vuetify.lang.t(a,e)},on:{click:()=>this.$emit("input",e)}}),[e.toString()])},genItems(t){return this.items.map(((e,s)=>t("li",{key:s},[isNaN(Number(e))?t("span",{class:"v-pagination__more"},[e.toString()]):this.genItem(t,e)])))},genList(t,e){return t("ul",{directives:[{modifiers:{quiet:!0},name:"resize",value:this.onResize}],class:this.classes},e)}},render(t){const e=[this.genIcon(t,this.$vuetify.rtl?this.nextIcon:this.prevIcon,this.value<=1,this.previous,this.$vuetify.lang.t(this.previousAriaLabel)),this.genItems(t),this.genIcon(t,this.$vuetify.rtl?this.prevIcon:this.nextIcon,this.value>=this.length,this.next,this.$vuetify.lang.t(this.nextAriaLabel))];return t("nav",{attrs:{role:"navigation","aria-label":this.$vuetify.lang.t(this.wrapperAriaLabel)}},[this.genList(t,e)])}}),D=s(351),S=s(9404),x=s(7265),_=(0,f.A)(v.A).extend({name:"v-simple-table",props:{dense:Boolean,fixedHeader:Boolean,height:[Number,String]},computed:{classes(){return{"v-data-table--dense":this.dense,"v-data-table--fixed-height":!!this.height&&!this.fixedHeader,"v-data-table--fixed-header":this.fixedHeader,"v-data-table--has-top":!!this.$slots.top,"v-data-table--has-bottom":!!this.$slots.bottom,...this.themeClasses}}},methods:{genWrapper(){return this.$slots.wrapper||this.$createElement("div",{staticClass:"v-data-table__wrapper",style:{height:(0,x.Dg)(this.height)}},[this.$createElement("table",(0,x.$c)(this))])}},render(t){return t("div",{staticClass:"v-data-table",class:this.classes},[(0,x.$c)(this,"top"),this.genWrapper(),(0,x.$c)(this,"bottom")])}}),y=s(6583),A=s(8822),L=s(7467),$=s(8128),C=function(){var t=this,e=t._self._c;return t.serviceList.length>0?e(c.A,{attrs:{fluid:""}},[e(r.A,{staticClass:"mt-1"},[e(L.A,{attrs:{dense:"",flat:""}},[e(a.A,{attrs:{icon:""},on:{click:t.goBackHomePage}},[e(h.A,[t._v("mdi-arrow-left")])],1)],1),e(o.ri,[t._v(t._s(t.collectionTitle))]),e(o.ZR,[t._v(t._s(t.breadcrumbs))]),e(o.OQ,{staticClass:"pt-4"},[e(D.A,[e(l.A,{attrs:{cols:"12",md:"6"}},[e("div",{staticClass:"max-w-400"},[e(A.A,{staticClass:"shrink",attrs:{dense:"",clearable:"","hide-details":"",placeholder:t.$t("message.3"),"append-icon":"mdi-magnify"},on:{input:function(e){return t.getDocumentList()}},scopedSlots:t._u([{key:"append-outer",fn:function(){return[e($.A,{attrs:{top:""},scopedSlots:t._u([{key:"activator",fn:function({on:s,attrs:i}){return[e(a.A,t._g(t._b({staticStyle:{"margin-top":"-10px"},attrs:{fab:"",small:"",depressed:"",color:"btnIndigo"},on:{click:function(e){return t.fromClipboard()}}},"v-btn",i,!1),s),[e(h.A,{attrs:{color:"white"}},[t._v("mdi-content-paste")])],1)]}}],null,!1,3374460323)},[e("span",[t._v(t._s(t.$t("message.71")))])])]},proxy:!0}],null,!1,4174525776),model:{value:t.updateSearchQuery,callback:function(e){t.updateSearchQuery=e},expression:"updateSearchQuery"}})],1)]),e(l.A,{staticClass:"text-md-right",attrs:{cols:"12",md:"6"}},[e(a.A,{attrs:{rounded:"",depressed:"",color:"btnIndigo",to:t.docUrlWithoutID+"/new"}},[e(h.A,{attrs:{color:"white",left:""}},[t._v("mdi-file-plus-outline")]),e("span",[t._v(t._s(t.$t("message.25")))])],1)],1)],1),e(D.A,{staticClass:"mb-4 mt-12"},[e(l.A,{staticClass:"py-0",attrs:{cols:"auto"}},[e("div",{staticClass:"w-260"},[e(S.A,{attrs:{dense:"","hide-details":"","item-color":"control",items:t.itemsSortDocList()},on:{change:function(e){return t.getDocumentList()}},model:{value:t.updateSortDocList,callback:function(e){t.updateSortDocList=e},expression:"updateSortDocList"}})],1)]),e(l.A,{staticClass:"py-0",attrs:{cols:"auto"}},[e("div",{staticClass:"w-180"},[e(S.A,{attrs:{dense:"","hide-details":"","item-color":"control",items:t.itemsSortDirectDocList()},on:{change:function(e){return t.getDocumentList()}},model:{value:t.updateSortDirectDocList,callback:function(e){t.updateSortDirectDocList=e},expression:"updateSortDirectDocList"}})],1)]),e(l.A,{staticClass:"py-0",attrs:{cols:"auto"}},[e(a.A,{attrs:{small:"",rounded:"",depressed:"",color:"btnIndigo",disabled:0===t.dataFilter.length},on:{click:function(e){t.showFilterDoc=!0}}},[e(h.A,{attrs:{color:"white",left:""}},[t._v("mdi-filter")]),e("span",[t._v(t._s(t.$t("message.64")))])],1)],1),e(l.A,{staticClass:"py-0",attrs:{cols:"auto"}},[t.docsToBeDelete.length>0?e(a.A,{attrs:{small:"",rounded:"",depressed:"",color:"btnRed"},on:{click:function(e){return t.deleteDocs()}}},[e(h.A,{attrs:{color:"white",left:""}},[t._v("mdi-delete")]),e("span",[t._v(t._s(t.$t("message.4")))])],1):t._e()],1)],1),e(_,{staticClass:"mt-4",attrs:{"fixed-header":""},scopedSlots:t._u([{key:"default",fn:function(){return[e("thead",{staticClass:"document-list",style:t.$vuetify.theme.dark?"background: #1d1f34;":"background: #f5f6fb;"},[e("tr",[e("th",{staticStyle:{"text-align":"left !important"},attrs:{align:"left"}},[t._v(" № ")]),e("th",{attrs:{align:"center"}},[e(n.A,{staticClass:"mt-0 pt-0",attrs:{"hide-details":"",color:"error",disabled:0===t.documents.length},on:{change:function(e){return t.markAllDocsForDeletion()}},model:{value:t.deleteAllDocsFlag,callback:function(e){t.deleteAllDocsFlag=e},expression:"deleteAllDocsFlag"}})],1),t._l(t.fields,(function(s,i){return e("th",{key:`header-${i}`,attrs:{align:"center"}},[t._v(" "+t._s(s.title)+" ")])})),e("th",{attrs:{align:"center"}},[t._v(t._s(t.$t("message.29")))]),e("th",{attrs:{align:"center"}},[t._v(t._s(t.$t("message.30")))]),e("th",{attrs:{align:"center"}},[t._v("ID")])],2)]),e("tbody",{staticClass:"document-list"},t._l(t.documents,(function(s,i){return e("tr",{key:`doc-${i}`},[e("td",{staticClass:"pr-0",staticStyle:{"text-align":"left !important"},attrs:{width:"34",align:"left"}},[t._v(" "+t._s(i+t.progressionStep)+" ")]),e("td",{staticClass:"pr-0",attrs:{width:"34",align:"center"}},[e(n.A,{staticClass:"mt-0 pt-0",attrs:{"hide-details":"",value:i,color:"error"},on:{change:function(e){return t.checkStatusListSelectedDocsDelete()}},model:{value:t.docsToBeDelete,callback:function(e){t.docsToBeDelete=e},expression:"docsToBeDelete"}})],1),t._l(t.fields,(function(r,o){return[e("td",{key:o,attrs:{align:"center",width:o?"":"100"}},[o?e("span",{domProps:{innerHTML:t._s(s[r.field])}}):[e("table",{attrs:{width:"100%"}},[e("tr",[e("td",{attrs:{width:"40"}},[e($.A,{attrs:{top:""},scopedSlots:t._u([{key:"activator",fn:function({on:i,attrs:o}){return[e(a.A,t._g(t._b({staticClass:"mr-2",attrs:{fab:"","x-small":"",depressed:"",color:"btnIndigo"},on:{click:function(e){return t.toClipboard(s[r.field])}}},"v-btn",o,!1),i),[e(h.A,{attrs:{color:"white"}},[t._v("mdi-content-copy")])],1)]}}],null,!0)},[e("span",[t._v(t._s(s[r.field]))])])],1),e("td",{attrs:{align:"left",width:"100"}},[e(a.A,{staticClass:"btn-doc-name",attrs:{small:"",block:"",rounded:"",depressed:"",color:"btnIndigo",to:t.getDocFormUrl(i)}},[e(h.A,{attrs:{color:"white",left:""}},[t._v("mdi-open-in-new")]),t._v(" "+t._s(t._f("truncate")(s[r.field],30))+" ")],1)],1)])])]],2)]})),e("td",{attrs:{width:"180"},domProps:{innerHTML:t._s(t.formattingDate(s.created_at))}}),e("td",{attrs:{width:"180"},domProps:{innerHTML:t._s(t.formattingDate(s.updated_at))}}),e("td",{attrs:{width:"40",align:"center"}},[e($.A,{attrs:{top:""},scopedSlots:t._u([{key:"activator",fn:function({on:i,attrs:r}){return[e(a.A,t._g(t._b({attrs:{fab:"","x-small":"",depressed:"",color:"btnIndigo"},on:{click:function(e){return t.toClipboard(s.hash)}}},"v-btn",r,!1),i),[e(h.A,{attrs:{color:"white"}},[t._v("mdi-content-copy")])],1)]}}],null,!0)},[e("span",[t._v(t._s(s.hash))])])],1)],2)})),0)]},proxy:!0}],null,!1,2512627271)})],1),e(o.SL,[e(D.A,[e(l.A,{staticClass:"py-0",attrs:{cols:"12"}},[e("div",{staticClass:"w-80 block-center"},[e(S.A,{attrs:{dense:"","hide-details":"","item-color":"control",items:t.countPerPage},model:{value:t.updateDocsPerPage,callback:function(e){t.updateDocsPerPage=e},expression:"updateDocsPerPage"}})],1)]),e(l.A,{attrs:{cols:"12 pb-4"}},[t.documents.length>0?e(b,{attrs:{circle:"",color:"btnIndigo",length:t.pageCount,"total-visible":5},on:{input:function(e){t.getDocumentList(),t.updateProgressionStep()}},model:{value:t.updateCurrentPageNumber,callback:function(e){t.updateCurrentPageNumber=e},expression:"updateCurrentPageNumber"}}):t._e()],1)],1)],1)],1),e(u.A,{attrs:{persistent:"","max-width":"500px"},model:{value:t.showFilterDoc,callback:function(e){t.showFilterDoc=e},expression:"showFilterDoc"}},[e(r.A,[e(o.SL,{staticClass:"pr-3 pt-2 pb-0"},[e(y.A),e(a.A,{attrs:{icon:"",small:""},on:{click:function(e){t.showFilterDoc=!1}}},[e(h.A,{attrs:{color:"error"}},[t._v("mdi-close")])],1)],1),e(o.ri,{staticClass:"pt-0 pb-6"},[t._v(t._s(t.$t("message.65")))]),e(o.OQ,[e(D.A,{attrs:{justify:"center"}},t._l(t.dataFilter,(function(s,r){return e(l.A,{key:`filter-${r}`,staticClass:"mb-4",attrs:{cols:"12"}},[e(i.A,{staticClass:"shrink",attrs:{dense:"",chips:s.multiple,"deletable-chips":s.multiple,"small-chips":s.multiple,clearable:"","hide-details":"","item-text":"title","item-value":"value",label:s.label,multiple:s.multiple,items:s.items},on:{input:function(e){return t.getDocumentList()}},scopedSlots:t._u([{key:"prepend",fn:function(){return[e($.A,{attrs:{top:""},scopedSlots:t._u([{key:"activator",fn:function({on:i}){return[e(a.A,{attrs:{fab:"","x-small":"",depressed:"",color:s.negation?"btnIndigo":"btnRed"},on:{click:function(e){s.negation=!s.negation,t.getDocumentList()}}},[e(h.A,t._g({attrs:{color:"white"}},i),[t._v(t._s(s.negation?"mdi-minus":"mdi-plus"))])],1)]}}],null,!0)},[t._v(" "+t._s(t.$t("message.69"))+" ")])]},proxy:!0}],null,!0),model:{value:t.selectDataFilter[s.field],callback:function(e){t.$set(t.selectDataFilter,s.field,e)},expression:"selectDataFilter[filter.field]"}})],1)})),1)],1)],1)],1)],1):t._e()},w=[],k=s(5353),P={name:"DocumentList",data:()=>({deleteAllDocsFlag:!1,docsToBeDelete:[],countPerPage:[10,20,30,40,50,60,70,80,90,100],showFilterDoc:!1,docUrlWithoutID:""}),computed:{...(0,k.aH)(["serviceList","selectedService","service","indexService","collection","indexCollection"]),...(0,k.aH)("documentList",["documents","currentPageNumber","pageCount","progressionStep","docsPerPage","sortDocList","sortDirectDocList","sortTypes","searchQuery","dataFilter","selectDataFilter"]),updateCurrentPageNumber:{get:function(){return this.currentPageNumber},set:function(t){this.deleteAllDocsFlag=!1,this.docsToBeDelete=[],this.setCurrentPageNumber(t)}},updateSearchQuery:{get:function(){return this.searchQuery},set:function(t){this.setSearchQuery(t?t.trim():t)}},updateDocsPerPage:{get:function(){return this.docsPerPage},set:function(t){this.setDocsPerPage(t)}},updateSortDocList:{get:function(){return this.sortDocList},set:function(t){this.setSortDocList(t)}},updateSortDirectDocList:{get:function(){return this.sortDirectDocList},set:function(t){this.setSortDirectDocList(t)}},collectionTitle:function(){return this.serviceList[this.indexService].collections[this.indexCollection].title},breadcrumbs:function(){const t=this.serviceList[this.indexService].service.title;return`${t} > ${this.collectionTitle}`},fields:function(){return this.serviceList[this.indexService].collections[this.indexCollection].fields}},filters:{upperCase:function(t){return t?(t=t.toString(),t.toUpperCase()):""}},methods:{...(0,k.PY)(["setSelectedService","setService","setIndexService","setCollection","setIndexCollection"]),...(0,k.PY)("navigationBar",["setCurrentIndexService"]),...(0,k.PY)("documentList",["setCurrentPageNumber","setProgressionStep","setDocsPerPage","setSortDocList","setSortDirectDocList","setSearchQuery"]),...(0,k.PY)("popUpMsg",["setShowMsg"]),...(0,k.i0)("documentList",["ajaxGetDocumentList","ajaxGetDataFilter","resetToDefault"]),...(0,k.i0)("popUpMsg",["runShowMsg"]),...(0,k.i0)("pageLockout",["runShowOverlayPageLockout"]),goBackHomePage(){this.setCurrentIndexService(null),this.setSelectedService(this.selectedService.map((function(){}))),this.setShowMsg(!1),this.$router.replace({name:"home"})},getUrlNoIndexDoc:function(){this.docUrlWithoutID=`/${this.serviceTitle}/${this.indexService}/${this.collectionTitle}/${this.indexCollection}/document`},fromClipboard(){this.updateSearchQuery="",navigator.clipboard?navigator.clipboard.readText().then((t=>{this.updateSearchQuery=t,this.getDocumentList()})).catch((t=>{this.runShowMsg({text:t,status:"error"})})):this.runShowMsg({text:`${this.$t("message.12")}<br/>${this.$t("message.63")}`,status:"error"})},itemsSortDocList(){return[{text:this.$t("message.40"),value:this.sortTypes[0]},{text:this.$t("message.29"),value:this.sortTypes[1]},{text:this.$t("message.30"),value:this.sortTypes[2]}]},itemsSortDirectDocList(){return[{text:this.$t("message.42"),value:-1},{text:this.$t("message.43"),value:1}]},toClipboard(t){navigator.clipboard?navigator.clipboard.writeText(t).then((()=>{})).catch((t=>{this.runShowMsg({text:t,status:"error"})})):this.runShowMsg({text:`${this.$t("message.12")}<br/>${this.$t("message.63")}`,status:"error"})},getDocumentList(){return this.setShowMsg(!1),this.runShowOverlayPageLockout(!0),this.docsToBeDelete.length>0&&(this.deleteAllDocsFlag=!1,this.docsToBeDelete=[]),new Promise(((t,e)=>{this.ajaxGetDocumentList({indexService:this.indexService,indexCollection:this.indexCollection}).then((()=>{this.runShowOverlayPageLockout(!1),t()})).catch((t=>{console.log(t),this.runShowOverlayPageLockout(!1),this.runShowMsg({text:t,status:"error"}),e(t)}))}))},getDocFormUrl(t){return`${this.docUrlWithoutID}/${t}`},formattingDate(t){const e=new Date(t+"Z"),s=e.toLocaleDateString([this.$userLang,"en"]),i=e.toLocaleTimeString().slice(0,8);return`<span class="cyan--text text--darken-1 font-weight-black">${s}</span> <span class="orange--text text--darken-1 font-weight-black">${i}</span>`},markAllDocsForDeletion(){this.docsToBeDelete=this.deleteAllDocsFlag?[...Array(this.documents.length).keys()]:[]},checkStatusListSelectedDocsDelete(){this.deleteAllDocsFlag=this.docsToBeDelete.length===this.documents.length},deleteDocs(){this.setShowMsg(!1),this.runShowOverlayPageLockout(!0);const t=this.serviceList[this.indexService],e=[];this.docsToBeDelete.forEach((t=>{e.push(this.documents[t].hash)}));const s={model_key:t.collections[this.indexCollection].model_key,doc_hash_list:JSON.stringify(e)};this.axios.post("/admin/delete-doc-list",s).then((t=>{const e=t.data;e.is_authenticated?0===e.msg_err.length?(this.setShowMsg(!1),this.getDocumentList()):(console.log(e.msg_err),this.runShowOverlayPageLockout(!1),this.runShowMsg({text:e.msg_err,status:"error"})):(this.runShowOverlayPageLockout(!1),this.setIsAuthenticated(!1))})).catch((t=>{console.log(t),this.runShowOverlayPageLockout(!1),this.runShowMsg({text:t,status:"error"})}))},updateProgressionStep(){const t=this.currentPageNumber;this.setProgressionStep(this.docsPerPage*(t-1)+1)}},created(){this.setService(this.$route.params.service),this.setIndexService(this.$route.params.indexService),this.setCollection(this.$route.params.collection),this.setIndexCollection(this.$route.params.indexCollection),this.resetToDefault(),this.getUrlNoIndexDoc(),this.getDocumentList(),this.ajaxGetDataFilter().catch((t=>{console.log(t),this.runShowOverlayPageLockout(!1),this.runShowMsg({text:t,status:"error"})}))}},I=P,T=s(1656),F=(0,T.A)(I,C,w,!1,null,null,null),M=F.exports}}]);
//# sourceMappingURL=148.ea89e5ce.js.map