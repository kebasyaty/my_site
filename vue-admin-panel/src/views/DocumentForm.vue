<template>
  <v-container fluid>
    <!-- Form for document. -->
    <v-card class="mt-1" max-width="1000">
      <v-toolbar dense flat>
        <v-btn icon @click="goBack()">
          <v-icon>mdi-arrow-left</v-icon>
        </v-btn>
        <v-spacer></v-spacer>
        <!-- Update password. -->
        <v-dialog
          v-if="is_password && $route.params.indexDoc !== 'new'"
          v-model="dialogUpdatePassword"
          persistent
          max-width="600px"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              dark
              rounded
              depressed
              color="green darken-2"
              v-bind="attrs"
              v-on="on"
              ><span>{{ $t("message.46") }}</span></v-btn
            >
          </template>
          <v-card ref="updatePasswordForm">
            <v-card-actions class="pr-3 pt-2 pb-0">
              <v-spacer></v-spacer>
              <!-- Button - Close. -->
              <v-btn
                icon
                small
                color="red"
                @click="[updatePassResetForm(), (dialogUpdatePassword = false)]"
              >
                <v-icon>mdi-close</v-icon>
              </v-btn>
            </v-card-actions>
            <v-card-title class="pt-0">
              <span class="h6">{{ $t("message.46") }}</span>
            </v-card-title>
            <v-card-text>
              <v-text-field
                ref="passwordOld"
                class="mt-0 pt-0"
                autofocus
                required
                clearable
                counter
                :append-icon="
                  dataUpdatePassword.see_pass ? 'mdi-eye' : 'mdi-eye-off'
                "
                :type="dataUpdatePassword.see_pass ? 'text' : 'password'"
                :placeholder="$t('message.47')"
                v-model="dataUpdatePassword.passwordOld"
                :maxlength="256"
                @click:append="
                  dataUpdatePassword.see_pass = !dataUpdatePassword.see_pass
                "
                :rules="[
                  () => !!dataUpdatePassword.passwordOld || $t('message.51'),
                ]"
              ></v-text-field>
              <div>
                <v-text-field
                  id="newPassword"
                  ref="passwordNew"
                  class="mt-0 pt-0"
                  required
                  clearable
                  counter
                  :append-icon="
                    dataUpdatePassword.see_pass ? 'mdi-eye' : 'mdi-eye-off'
                  "
                  :type="dataUpdatePassword.see_pass ? 'text' : 'password'"
                  :placeholder="$t('message.48')"
                  :hint="$t('message.50')"
                  v-model="dataUpdatePassword.passwordNew"
                  :maxlength="256"
                  @click:append="
                    dataUpdatePassword.see_pass = !dataUpdatePassword.see_pass
                  "
                  :rules="[
                    () => !!dataUpdatePassword.passwordNew || $t('message.51'),
                    () =>
                      /^[a-z0-9@#$%^&+=*!~)(]{8,256}$/i.test(
                        dataUpdatePassword.passwordNew
                      ) || $t('message.50'),
                  ]"
                ></v-text-field>
                <password
                  v-model="valuePasswordStrength"
                  :strength-meter-only="true"
                  :class="$vuetify.theme.dark ? 'theme--dark' : 'theme--light'"
                />
              </div>
              <v-text-field
                ref="passwordRepeat"
                class="mt-0 pt-0"
                required
                clearable
                counter
                :append-icon="
                  dataUpdatePassword.see_pass ? 'mdi-eye' : 'mdi-eye-off'
                "
                :type="dataUpdatePassword.see_pass ? 'text' : 'password'"
                :placeholder="$t('message.49')"
                v-model="dataUpdatePassword.passwordRepeat"
                :maxlength="256"
                @click:append="
                  dataUpdatePassword.see_pass = !dataUpdatePassword.see_pass
                "
                :rules="[
                  () => !!dataUpdatePassword.passwordRepeat || $t('message.51'),
                  () =>
                    dataUpdatePassword.passwordRepeat ===
                      dataUpdatePassword.passwordNew || $t('message.52'),
                ]"
              ></v-text-field>
            </v-card-text>
            <v-card-actions class="pt-0">
              <!-- Button - Generate password -->
              <v-tooltip top>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    fab
                    dark
                    x-small
                    depressed
                    v-bind="attrs"
                    v-on="on"
                    color="orange darken-2"
                    :loading="dataUpdatePassword.generate"
                    :disabled="dataUpdatePassword.generate"
                    @click="customPassword()"
                  >
                    <v-icon>mdi-cached</v-icon>
                  </v-btn>
                </template>
                {{ $t("message.66") }}
              </v-tooltip>
              <!-- Button - Copy password -->
              <v-tooltip top>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    fab
                    dark
                    x-small
                    depressed
                    v-bind="attrs"
                    v-on="on"
                    color="green darken-2"
                    :loading="dataUpdatePassword.generate"
                    :disabled="dataUpdatePassword.generate"
                    @click="copyPassword()"
                    class="mx-4"
                  >
                    <v-icon>mdi-content-copy</v-icon>
                  </v-btn>
                </template>
                {{ $t("message.67") }}
              </v-tooltip>
              <!-- Button - Refresh form -->
              <v-tooltip top>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    fab
                    dark
                    x-small
                    depressed
                    v-bind="attrs"
                    v-on="on"
                    color="purple darken-2"
                    class="my-0"
                    @click="updatePassResetForm()"
                  >
                    <v-icon>mdi-refresh</v-icon>
                  </v-btn>
                </template>
                {{ $t("message.68") }}
              </v-tooltip>
              <v-spacer></v-spacer>
              <!-- Button - Update -->
              <v-tooltip top>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    fab
                    dark
                    x-small
                    depressed
                    v-bind="attrs"
                    v-on="on"
                    color="blue darken-2"
                    @click="updatePassword()"
                  >
                    <v-icon>mdi-content-save</v-icon>
                  </v-btn>
                </template>
                {{ $t("message.55") }}
              </v-tooltip>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
      <v-card-title class="pt-0">{{ docTitle }}</v-card-title>
      <v-card-subtitle class="pt-1">{{ breadcrumbs }}</v-card-subtitle>
      <!-- Form fields. -->
      <v-card-text class="pa-4" v-if="render">
        <form :id="getIdForm()" class="document-form">
          <template v-for="field in fields">
            <!-- Hash field -->
            <template v-if="field.field_type === 'HiddenHash'">
              <input
                :key="field.name"
                v-model="fieldsData[field.name]"
                :label="field.label"
                :id="field.id"
                :type="field.input_type"
                :name="field.name"
              />
              <!-- Alert message for the entire web form. -->
              <v-alert
                v-if="field.alert.length > 0"
                :key="field.name"
                text
                dense
                color="deep-orange"
                icon="mdi-alert"
                border="left"
                >{{ field.alert }}</v-alert
              >
            </template>
            <!-- Others fields. -->
            <div v-else :key="field.name">
              <div v-show="!field.is_hide" class="rounded-lg">
                <!-- Wrapper for fields. -->
                <v-card flat outlined class="mt-4">
                  <v-card-text
                    :class="
                      field.field_type !== 'CheckBox'
                        ? 'pt-2 pb-0'
                        : 'pt-2 pb-4'
                    "
                  >
                    <div v-if="field.field_type !== 'CheckBox'">
                      <!-- Title of field. -->
                      <v-card-title
                        class="pa-0 text-subtitle-1 font-weight-medium"
                      >
                        {{ field.label }}
                        <span v-if="field.required" class="red--text pl-2"
                          >&#9913;</span
                        >
                      </v-card-title>
                      <!-- Hint for field. -->
                      <v-card-subtitle
                        v-if="field.hint.length > 0"
                        class="pl-0 pb-1 pt-3"
                        v-html="field.hint"
                      ></v-card-subtitle>
                      <!-- Dialogue for fields with dynamic type. -->
                      <v-dialog
                        persistent
                        max-width="600px"
                        v-model="dynDataDialog[field.name]"
                        v-if="field.field_type.includes('Dyn')"
                      >
                        <v-card>
                          <v-card-actions class="pr-3 pt-2 pb-0">
                            <v-spacer></v-spacer>
                            <!-- Button - Close. -->
                            <v-btn
                              icon
                              small
                              color="red"
                              @click="
                                [
                                  (dynDataDialog[field.name] = false),
                                  (addDynDataElem = {
                                    title: null,
                                    value: null,
                                  }),
                                  (delDynDataValue = null),
                                  setShowMsg(false),
                                  runShowOverlayPageLockout(false),
                                ]
                              "
                            >
                              <v-icon>mdi-close</v-icon>
                            </v-btn>
                          </v-card-actions>
                          <!-- Add new list item. -->
                          <v-card-text class="pb-0">
                            <v-card-title class="pa-0 font-size-1-4-rem"
                              ><v-spacer></v-spacer>{{ field.label
                              }}<v-spacer></v-spacer
                            ></v-card-title>
                            <v-card-title class="px-0 py-2 font-size-1-1-rem">{{
                              $t("message.22")
                            }}</v-card-title>
                            <v-card-subtitle class="px-0 py-2">
                              <span class="font-weight-medium green--text">{{
                                $t("message.41")
                              }}</span>
                              <br />
                              <span
                                class="orange--text text--darken-1 font-weight-black"
                                >{{ $t("message.23") }}:&ensp;</span
                              >
                              <span>{{ $t("message.57") }}</span>
                              <br />
                              <span
                                class="orange--text text--darken-1 font-weight-black"
                                >{{ $t("message.24") }}:&ensp;</span
                              >
                              <template>
                                <span
                                  v-if="field.field_type.includes('Text')"
                                  >{{ $t("message.57") }}</span
                                >
                                <span
                                  v-else-if="field.field_type.includes('U32')"
                                  >{{ $t("message.58") }}</span
                                >
                                <span
                                  v-else-if="field.field_type.includes('I32')"
                                  >{{ $t("message.59") }}</span
                                >
                                <span
                                  v-else-if="field.field_type.includes('I64')"
                                  >{{ $t("message.60") }}</span
                                >
                                <span
                                  v-else-if="field.field_type.includes('F64')"
                                  >{{ $t("message.61") }}</span
                                >
                              </template>
                            </v-card-subtitle>
                            <v-row>
                              <v-col cols="12" sm="6">
                                <v-text-field
                                  clearable
                                  :label="$t('message.23')"
                                  v-model="addDynDataElem.title"
                                ></v-text-field>
                              </v-col>
                              <v-col cols="12" sm="6">
                                <v-text-field
                                  v-if="field.field_type.includes('Text')"
                                  clearable
                                  :label="$t('message.24')"
                                  v-model="addDynDataElem.value"
                                ></v-text-field>
                                <v-text-field
                                  v-else
                                  clearable
                                  :label="$t('message.24')"
                                  type="number"
                                  v-model="addDynDataElem.value"
                                ></v-text-field>
                              </v-col>
                            </v-row>
                          </v-card-text>
                          <v-card-actions>
                            <v-spacer></v-spacer>
                            <!-- Button - Save. -->
                            <v-btn
                              dark
                              small
                              rounded
                              depressed
                              color="blue darken-2"
                              :disabled="
                                !addDynDataElem.title || !addDynDataElem.value
                              "
                              @click="updateDynData(field.name, false)"
                              ><span>{{ $t("message.19") }}</span></v-btn
                            >
                          </v-card-actions>
                          <v-divider></v-divider>
                          <!-- Remove irrelevant item. -->
                          <v-card-text class="pb-0">
                            <v-card-title
                              class="px-0 pt-6 pb-0 font-size-1-1-rem"
                              >{{ $t("message.20") }}</v-card-title
                            >
                            <v-autocomplete
                              dense
                              clearable
                              item-text="title"
                              item-value="value"
                              item-color="red darken-3"
                              color="red darken-3"
                              :disabled="field.options.length === 0"
                              class="shrink"
                              v-model="delDynDataValue"
                              :items="field.options"
                            >
                              <template v-slot:item="{ item, attrs, on }">
                                <v-list-item v-on="on" v-bind="attrs">
                                  <v-list-item-icon>
                                    <v-icon color="red darken-3"
                                      >mdi-delete</v-icon
                                    >
                                  </v-list-item-icon>
                                  <v-list-item-content>
                                    <v-list-item-title
                                      v-html="item.title"
                                    ></v-list-item-title>
                                    <v-list-item-subtitle
                                      v-html="item.value"
                                    ></v-list-item-subtitle>
                                  </v-list-item-content>
                                </v-list-item>
                              </template>
                            </v-autocomplete>
                          </v-card-text>
                          <v-card-actions class="pt-3">
                            <v-spacer></v-spacer>
                            <!-- Button - Delete. -->
                            <v-btn
                              dark
                              small
                              rounded
                              depressed
                              color="red darken-2"
                              :disabled="delDynDataValue === null"
                              @click="updateDynData(field.name, true)"
                              ><spam>{{ $t("message.21") }}</spam></v-btn
                            >
                          </v-card-actions>
                        </v-card>
                      </v-dialog>
                    </div>

                    <!-- Text fields -->
                    <v-text-field
                      class="mt-0 pt-0"
                      v-if="
                        [
                          'InputText',
                          'InputEmail',
                          'InputPassword',
                          'InputPhone',
                          'InputUrl',
                          'InputIP',
                          'InputIPv4',
                          'InputIPv6',
                          'AutoSlug',
                        ].includes(field.field_type)
                      "
                      clearable
                      counter
                      :prepend-icon="`mdi-${getFieldIcon(field.field_type)}`"
                      v-model="fieldsData[field.name]"
                      :id="field.id"
                      :type="field.input_type"
                      :name="field.name"
                      :placeholder="field.placeholder"
                      :required="field.required"
                      :disabled="field.disabled"
                      :readonly="field.readonly"
                      :maxlength="field.maxlength"
                      :class="field.css_classes"
                      :messages="field.warning"
                      :error-messages="field.error"
                    ></v-text-field>

                    <!-- Number fields -->
                    <div
                      v-if="
                        [
                          'NumberI32',
                          'NumberU32',
                          'NumberI64',
                          'NumberF64',
                        ].includes(field.field_type)
                      "
                    >
                      <div v-if="field.min !== null || field.max !== null">
                        <v-divider class="mb-1"></v-divider>
                        <span>{{ `step: ${field.step}` }}</span>
                        <span v-if="field.min !== null" class="ml-2">{{
                          `min: ${field.min}`
                        }}</span>
                        <span v-if="field.max !== null" class="ml-2">{{
                          `max: ${field.max}`
                        }}</span>
                      </div>
                      <v-text-field
                        class="mt-0 pt-1"
                        clearable
                        :prepend-icon="`mdi-${getFieldIcon(field.field_type)}`"
                        v-model="fieldsData[field.name]"
                        :id="field.id"
                        :type="field.input_type"
                        :name="field.name"
                        :placeholder="field.placeholder"
                        :required="field.required"
                        :disabled="field.disabled"
                        :readonly="field.readonly"
                        :step="field.step"
                        :min="field.min"
                        :max="field.max"
                        :class="field.css_classes"
                        :messages="field.warning"
                        :error-messages="field.error"
                      ></v-text-field>
                    </div>

                    <!-- Range fields -->
                    <div
                      v-if="
                        [
                          'RangeI32',
                          'RangeU32',
                          'RangeI64',
                          'RangeF64',
                        ].includes(field.field_type)
                      "
                    >
                      <v-divider class="mb-1"></v-divider>
                      <div>{{ `value: ${fieldsData[field.name]}` }}</div>
                      <span>{{ `step: ${field.step}` }}</span>
                      <span class="ml-2">{{ `min: ${field.min}` }}</span>
                      <span class="ml-2">{{ `max: ${field.max}` }}</span>
                      <v-slider
                        thumb-label
                        :prepend-icon="`mdi-${getFieldIcon(field.field_type)}`"
                        v-model="fieldsData[field.name]"
                        :id="field.id"
                        :type="field.input_type"
                        :name="field.name"
                        :placeholder="field.placeholder"
                        :required="field.required"
                        :disabled="field.disabled"
                        :readonly="field.readonly"
                        :step="field.step"
                        :min="field.min"
                        :max="field.max"
                        :class="field.css_classes"
                        :messages="field.warning"
                        :error-messages="field.error"
                      ></v-slider>
                    </div>

                    <!-- Radio buttons fields -->
                    <v-radio-group
                      class="mt-1"
                      v-if="
                        [
                          'RadioText',
                          'RadioI32',
                          'RadioU32',
                          'RadioI64',
                          'RadioF64',
                        ].includes(field.field_type)
                      "
                      v-model="fieldsData[field.name]"
                      :messages="field.warning"
                      :error-messages="field.error"
                    >
                      <v-radio
                        v-for="(item, idx) in field.options"
                        :key="item.title"
                        :id="`${field.id}-${idx}`"
                        :label="item.title"
                        :type="field.input_type"
                        :name="field.name"
                        :value="item.value"
                        :disabled="field.disabled"
                        :readonly="field.readonly"
                        :class="field.css_classes"
                      ></v-radio>
                    </v-radio-group>

                    <!-- Checkbox fields -->
                    <v-checkbox
                      class="mt-0"
                      persistent-hint
                      v-if="field.field_type === 'CheckBox'"
                      v-model="fieldsData[field.name]"
                      :id="field.id"
                      :label="field.label"
                      :type="field.input_type"
                      :name="field.name"
                      :hint="field.hint"
                      :disabled="field.disabled"
                      :readonly="field.readonly"
                      :class="field.css_classes"
                    ></v-checkbox>

                    <!-- File information -->
                    <div
                      v-if="
                        field.field_type === 'InputFile' &&
                        fieldsData[field.name].url.length > 0
                      "
                    >
                      <v-divider></v-divider>
                      <div
                        v-for="(item, index) in [
                          getFileIcon(
                            fieldsData[field.name].name.split('.').pop()
                          ),
                        ]"
                        :key="`${item.icon}-${index}`"
                      >
                        <v-sheet
                          rounded
                          color="white"
                          elevation="0"
                          height="60"
                          width="60"
                          class="my-1"
                        >
                          <v-icon light :color="item.color" size="60">{{
                            `mdi-${item.icon}`
                          }}</v-icon>
                        </v-sheet>
                      </div>
                      <v-btn
                        text
                        small
                        color="primary"
                        class="text-lowercase px-0"
                        :href="fieldsData[field.name].url"
                        target="_blank"
                        >{{ fieldsData[field.name].url }}</v-btn
                      >
                      <v-card-subtitle
                        v-if="fieldsData[field.name].size !== undefined"
                        class="pa-0"
                        >{{
                          `${$t("message.28")}: ${humanFileSize(
                            fieldsData[field.name].size
                          )}`
                        }}</v-card-subtitle
                      >
                      <v-checkbox
                        dense
                        hide-details
                        class="mt-0"
                        v-model="fieldsData[field.name].is_delete"
                        :label="`${$t('message.31')} ?`"
                        :disabled="field.required"
                      ></v-checkbox>
                    </div>

                    <!-- Image thumbnail -->
                    <div
                      v-if="
                        field.field_type === 'InputImage' &&
                        fieldsData[field.name].url.length > 0
                      "
                    >
                      <v-divider></v-divider>
                      <div class="mt-2 mb-1 h-60">
                        <img
                          class="rounded-lg"
                          :src="
                            fieldsData[field.name].url_xs ||
                            fieldsData[field.name].url
                          "
                          height="60"
                          alt="Image"
                        />
                      </div>
                      <v-btn
                        text
                        small
                        color="primary"
                        class="text-lowercase px-0"
                        :href="fieldsData[field.name].url"
                        target="_blank"
                        >{{ fieldsData[field.name].url }}</v-btn
                      >
                      <v-card-subtitle
                        v-if="fieldsData[field.name].size !== undefined"
                        class="pa-0"
                        >{{
                          `${$t("message.28")}: ${humanFileSize(
                            fieldsData[field.name].size
                          )}`
                        }}</v-card-subtitle
                      >
                      <v-checkbox
                        dense
                        hide-details
                        class="mt-0"
                        v-model="fieldsData[field.name].is_delete"
                        :label="`${$t('message.32')} ?`"
                        :disabled="field.required"
                      ></v-checkbox>
                    </div>

                    <!-- File fields -->
                    <v-file-input
                      class="mt-0 pt-1"
                      show-size
                      small-chips
                      :ref="field.name"
                      v-if="field.field_type === 'InputFile'"
                      :prepend-icon="`mdi-${getFieldIcon(field.field_type)}`"
                      :id="field.id"
                      :type="field.input_type"
                      :name="field.name"
                      :accept="field.accept"
                      :placeholder="field.placeholder"
                      :disabled="field.disabled"
                      :readonly="field.readonly"
                      :class="field.css_classes"
                      :messages="field.warning"
                      :error-messages="field.error"
                    ></v-file-input>

                    <!-- Image fields -->
                    <v-file-input
                      class="mt-0 pt-1"
                      show-size
                      small-chips
                      :ref="field.name"
                      v-if="field.field_type === 'InputImage'"
                      :prepend-icon="`mdi-${getFieldIcon(field.field_type)}`"
                      :id="field.id"
                      :type="field.input_type"
                      :name="field.name"
                      :accept="field.accept"
                      :placeholder="field.placeholder"
                      :disabled="field.disabled"
                      :readonly="field.readonly"
                      :class="field.css_classes"
                      :messages="field.warning"
                      :error-messages="field.error"
                    ></v-file-input>

                    <!-- Color fields -->
                    <v-menu
                      v-if="field.field_type === 'InputColor'"
                      :ref="field.name"
                      v-model="vMenu[field.name]"
                      :close-on-content-click="false"
                      :return-value.sync="fieldsData[field.name]"
                      :nudge-right="40"
                      transition="scale-transition"
                      offset-y
                      min-width="auto"
                    >
                      <template v-slot:activator="{ on, attrs }">
                        <v-text-field
                          class="mt-0 pt-1"
                          clearable
                          :background-color="fieldsData[field.name]"
                          :prepend-icon="`mdi-${getFieldIcon(
                            field.field_type
                          )}`"
                          v-model="fieldsData[field.name]"
                          :id="field.id"
                          :name="field.name"
                          :placeholder="field.placeholder"
                          :required="field.required"
                          :disabled="field.disabled"
                          readonly
                          :class="field.css_classes"
                          :messages="field.warning"
                          :error-messages="field.error"
                          v-bind="attrs"
                          v-on="on"
                          @input="defaultColor(field.name)"
                        ></v-text-field>
                      </template>
                      <v-card>
                        <v-color-picker
                          v-if="swatches.length > 0"
                          show-swatches
                          mode="hexa"
                          v-model="fieldsData[field.name]"
                          :disabled="field.disabled"
                          :readonly="field.readonly"
                          :swatches="swatches"
                        ></v-color-picker>
                        <v-color-picker
                          v-else
                          show-swatches
                          mode="hexa"
                          v-model="fieldsData[field.name]"
                          :disabled="field.disabled"
                          :readonly="field.readonly"
                        ></v-color-picker>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <v-btn
                            text
                            small
                            color="primary"
                            @click="vMenu[field.name] = false"
                            >{{ $t("message.18") }}</v-btn
                          >
                          <v-btn
                            text
                            small
                            color="primary"
                            @click="
                              $refs[field.name][0].save(fieldsData[field.name])
                            "
                            >OK</v-btn
                          >
                        </v-card-actions>
                      </v-card>
                    </v-menu>

                    <!-- Textarea fields -->
                    <div
                      v-if="field.field_type === 'TextArea'"
                      :class="
                        field.css_classes.includes('ckeditor')
                          ? 'mt-1 mb-2'
                          : ''
                      "
                    >
                      <div v-if="field.css_classes.includes('ckeditor')">
                        <ckeditor
                          :editor="classicCKEditor"
                          v-model="fieldsData[field.name]"
                          :config="configCKEditor"
                          :disabled="field.disabled"
                        ></ckeditor>
                        <v-alert
                          class="mt-1"
                          dense
                          outlined
                          type="warning"
                          v-if="field.warning.length > 0"
                          v-html="field.warning"
                        ></v-alert>
                        <v-alert
                          class="mt-1"
                          dense
                          outlined
                          type="error"
                          v-if="field.error.length > 0"
                          v-html="field.error"
                        ></v-alert>
                      </div>
                      <v-textarea
                        v-else
                        class="mt-0 pt-1"
                        counter
                        clearable
                        :prepend-icon="`mdi-${getFieldIcon(field.field_type)}`"
                        v-model="fieldsData[field.name]"
                        :id="field.id"
                        :name="field.name"
                        :placeholder="field.placeholder"
                        :required="field.required"
                        :disabled="field.disabled"
                        :readonly="field.readonly"
                        :maxlength="field.maxlength"
                        :class="field.css_classes"
                        :messages="field.warning"
                        :error-messages="field.error"
                      ></v-textarea>
                    </div>

                    <!-- Date fields -->
                    <div v-if="field.field_type === 'InputDate'">
                      <div v-if="field.min.length > 0 || field.max.length > 0">
                        <v-divider class="mb-1"></v-divider>
                        <span v-if="field.min.length > 0" class="ml-2">{{
                          `min: ${field.min}`
                        }}</span>
                        <span v-if="field.max.length > 0" class="ml-2">{{
                          `max: ${field.max}`
                        }}</span>
                      </div>
                      <v-menu
                        :ref="field.name"
                        v-model="vMenu[field.name]"
                        :close-on-content-click="false"
                        :return-value.sync="fieldsData[field.name]"
                        :nudge-right="40"
                        transition="scale-transition"
                        offset-y
                        min-width="auto"
                      >
                        <template v-slot:activator="{ on, attrs }">
                          <v-text-field
                            class="mt-0 pt-1"
                            clearable
                            :prepend-icon="`mdi-${getFieldIcon(
                              field.field_type
                            )}`"
                            v-model="showLocalDate[field.name]"
                            :id="field.id"
                            :name="field.name"
                            :placeholder="field.placeholder"
                            :required="field.required"
                            :disabled="field.disabled"
                            readonly
                            :class="field.css_classes"
                            :messages="field.warning"
                            :error-messages="field.error"
                            v-bind="attrs"
                            v-on="on"
                            @click:clear="fieldsData[field.name] = null"
                          ></v-text-field>
                        </template>
                        <!-- only min -->
                        <v-date-picker
                          v-if="field.min.length > 0 && field.max.length === 0"
                          scrollable
                          v-model="fieldsData[field.name]"
                          year-icon="mdi-calendar-blank"
                          color="primary"
                          :disabled="field.disabled"
                          :readonly="field.readonly"
                          :min="field.min"
                          @change="updateLocalDate(field.name)"
                        >
                          <v-spacer></v-spacer>
                          <v-btn
                            text
                            small
                            color="primary"
                            @click="vMenu[field.name] = false"
                            >{{ $t("message.18") }}</v-btn
                          >
                          <v-btn
                            text
                            small
                            color="primary"
                            @click="
                              $refs[field.name][0].save(fieldsData[field.name])
                            "
                            >OK</v-btn
                          >
                        </v-date-picker>
                        <!-- only max -->
                        <v-date-picker
                          v-else-if="
                            field.min.length === 0 && field.max.length > 0
                          "
                          scrollable
                          v-model="fieldsData[field.name]"
                          year-icon="mdi-calendar-blank"
                          color="primary"
                          :disabled="field.disabled"
                          :readonly="field.readonly"
                          :max="field.max"
                          @change="updateLocalDate(field.name)"
                        >
                          <v-spacer></v-spacer>
                          <v-btn
                            text
                            small
                            color="primary"
                            @click="vMenu[field.name] = false"
                            >{{ $t("message.18") }}</v-btn
                          >
                          <v-btn
                            text
                            small
                            color="primary"
                            @click="
                              $refs[field.name][0].save(fieldsData[field.name])
                            "
                            >OK</v-btn
                          >
                        </v-date-picker>
                        <!-- min and max -->
                        <v-date-picker
                          v-else-if="
                            field.min.length > 0 && field.max.length > 0
                          "
                          scrollable
                          v-model="fieldsData[field.name]"
                          year-icon="mdi-calendar-blank"
                          color="primary"
                          :disabled="field.disabled"
                          :readonly="field.readonly"
                          :min="field.min"
                          :max="field.max"
                          @change="updateLocalDate(field.name)"
                        >
                          <v-spacer></v-spacer>
                          <v-btn
                            text
                            small
                            color="primary"
                            @click="vMenu[field.name] = false"
                            >{{ $t("message.18") }}</v-btn
                          >
                          <v-btn
                            text
                            small
                            color="primary"
                            @click="
                              $refs[field.name][0].save(fieldsData[field.name])
                            "
                            >OK</v-btn
                          >
                        </v-date-picker>
                        <!-- without min and max -->
                        <v-date-picker
                          v-else
                          scrollable
                          v-model="fieldsData[field.name]"
                          year-icon="mdi-calendar-blank"
                          color="primary"
                          :disabled="field.disabled"
                          :readonly="field.readonly"
                          @change="updateLocalDate(field.name)"
                        >
                          <v-spacer></v-spacer>
                          <v-btn
                            text
                            small
                            color="primary"
                            @click="vMenu[field.name] = false"
                            >{{ $t("message.18") }}</v-btn
                          >
                          <v-btn
                            text
                            small
                            color="primary"
                            @click="
                              $refs[field.name][0].save(fieldsData[field.name])
                            "
                            >OK</v-btn
                          >
                        </v-date-picker>
                      </v-menu>
                    </div>

                    <!-- Date and Time fields -->
                    <div
                      v-if="
                        field.field_type === 'InputDateTime' ||
                        field.field_type === 'HiddenDateTime'
                      "
                    >
                      <div v-if="field.min.length > 0 || field.max.length > 0">
                        <v-divider class="mb-1"></v-divider>
                        <span v-if="field.min.length > 0" class="ml-2">{{
                          `min: ${field.min}`
                        }}</span>
                        <span v-if="field.max.length > 0" class="ml-2">{{
                          `max: ${field.max}`
                        }}</span>
                      </div>
                      <v-row>
                        <v-col cols="6">
                          <v-menu
                            :ref="field.name"
                            v-model="vMenu[field.name]"
                            :close-on-content-click="false"
                            :return-value.sync="fieldsData[field.name]"
                            :nudge-right="40"
                            transition="scale-transition"
                            offset-y
                            min-width="auto"
                          >
                            <template v-slot:activator="{ on, attrs }">
                              <v-text-field
                                class="mt-0 pt-1"
                                clearable
                                :prepend-icon="`mdi-${getFieldIcon(
                                  field.field_type
                                )}`"
                                v-model="showLocalDate[field.name]"
                                :id="field.id"
                                :name="field.name"
                                :placeholder="field.placeholder"
                                :required="field.required"
                                :disabled="field.disabled"
                                readonly
                                :class="field.css_classes"
                                :messages="field.warning"
                                :error-messages="field.error"
                                v-bind="attrs"
                                v-on="on"
                                @click:clear="fieldsData[field.name] = null"
                              ></v-text-field>
                            </template>
                            <!-- only min -->
                            <v-date-picker
                              v-if="
                                field.min.length > 0 && field.max.length === 0
                              "
                              scrollable
                              v-model="fieldsData[field.name]"
                              year-icon="mdi-calendar-blank"
                              color="primary"
                              :disabled="field.disabled"
                              :readonly="field.readonly"
                              :min="field.min"
                              @change="updateLocalDate(field.name)"
                            >
                              <v-spacer></v-spacer>
                              <v-btn
                                text
                                small
                                color="primary"
                                @click="vMenu[field.name] = false"
                                >{{ $t("message.18") }}</v-btn
                              >
                              <v-btn
                                text
                                small
                                color="primary"
                                @click="
                                  $refs[field.name][0].save(
                                    fieldsData[field.name]
                                  )
                                "
                                >OK</v-btn
                              >
                            </v-date-picker>
                            <!-- only max -->
                            <v-date-picker
                              v-else-if="
                                field.min.length === 0 && field.max.length > 0
                              "
                              scrollable
                              v-model="fieldsData[field.name]"
                              year-icon="mdi-calendar-blank"
                              color="primary"
                              :disabled="field.disabled"
                              :readonly="field.readonly"
                              :max="field.max"
                              @change="updateLocalDate(field.name)"
                            >
                              <v-spacer></v-spacer>
                              <v-btn
                                text
                                small
                                color="primary"
                                @click="vMenu[field.name] = false"
                                >{{ $t("message.18") }}</v-btn
                              >
                              <v-btn
                                text
                                small
                                color="primary"
                                @click="
                                  $refs[field.name][0].save(
                                    fieldsData[field.name]
                                  )
                                "
                                >OK</v-btn
                              >
                            </v-date-picker>
                            <!-- min and max -->
                            <v-date-picker
                              v-else-if="
                                field.min.length > 0 && field.max.length > 0
                              "
                              scrollable
                              v-model="fieldsData[field.name]"
                              year-icon="mdi-calendar-blank"
                              color="primary"
                              :disabled="field.disabled"
                              :readonly="field.readonly"
                              :min="field.min"
                              :max="field.max"
                              @change="updateLocalDate(field.name)"
                            >
                              <v-spacer></v-spacer>
                              <v-btn
                                text
                                small
                                color="primary"
                                @click="vMenu[field.name] = false"
                                >{{ $t("message.18") }}</v-btn
                              >
                              <v-btn
                                text
                                small
                                color="primary"
                                @click="
                                  $refs[field.name][0].save(
                                    fieldsData[field.name]
                                  )
                                "
                                >OK</v-btn
                              >
                            </v-date-picker>
                            <!-- without min and max -->
                            <v-date-picker
                              v-else
                              scrollable
                              v-model="fieldsData[field.name]"
                              year-icon="mdi-calendar-blank"
                              color="primary"
                              :disabled="field.disabled"
                              :readonly="field.readonly"
                              @change="updateLocalDate(field.name)"
                            >
                              <v-spacer></v-spacer>
                              <v-btn
                                text
                                small
                                color="primary"
                                @click="vMenu[field.name] = false"
                                >{{ $t("message.18") }}</v-btn
                              >
                              <v-btn
                                text
                                small
                                color="primary"
                                @click="
                                  $refs[field.name][0].save(
                                    fieldsData[field.name]
                                  )
                                "
                                >OK</v-btn
                              >
                            </v-date-picker>
                          </v-menu>
                        </v-col>
                        <v-col cols="6">
                          <v-menu
                            :ref="`${field.name}__time`"
                            v-model="vMenu[`${field.name}__time`]"
                            :close-on-content-click="false"
                            :nudge-right="40"
                            :return-value.sync="
                              fieldsData[`${field.name}__time`]
                            "
                            transition="scale-transition"
                            offset-y
                            max-width="290px"
                            min-width="290px"
                          >
                            <template v-slot:activator="{ on, attrs }">
                              <v-text-field
                                class="mt-0 pt-1"
                                clearable
                                prepend-icon="mdi-clock-time-four-outline"
                                v-model="fieldsData[`${field.name}__time`]"
                                :label="$t('message.17')"
                                :id="`${field.id}__time`"
                                type="time"
                                :name="`${field.name}__time`"
                                :placeholder="field.placeholder"
                                :required="field.required"
                                :disabled="field.disabled"
                                readonly
                                :class="field.css_classes"
                                v-bind="attrs"
                                v-on="on"
                                @click:clear="
                                  fieldsData[`${field.name}__time`] = null
                                "
                              ></v-text-field>
                            </template>
                            <v-time-picker
                              full-width
                              scrollable
                              v-if="vMenu[`${field.name}__time`]"
                              v-model="fieldsData[`${field.name}__time`]"
                              @click:minute="
                                $refs[`${field.name}__time`][0].save(
                                  fieldsData[`${field.name}__time`]
                                )
                              "
                              :disabled="field.disabled"
                              :readonly="field.readonly"
                            ></v-time-picker>
                          </v-menu>
                        </v-col>
                      </v-row>
                    </div>

                    <!-- Selection fields-->
                    <v-autocomplete
                      class="pt-0"
                      v-if="
                        [
                          'SelectText',
                          'SelectI32',
                          'SelectU32',
                          'SelectI64',
                          'SelectF64',
                        ].includes(field.field_type)
                      "
                      clearable
                      :prepend-icon="`mdi-${getFieldIcon(field.field_type)}`"
                      :items="field.options"
                      item-text="title"
                      item-value="value"
                      v-model="fieldsData[field.name]"
                      :id="field.id"
                      :name="field.name"
                      :placeholder="field.placeholder"
                      :required="field.required"
                      :disabled="field.disabled"
                      :readonly="field.readonly"
                      :class="field.css_classes"
                      :messages="field.warning"
                      :error-messages="field.error"
                    ></v-autocomplete>

                    <!-- Selection fields
                     (multiple)
                    -->
                    <v-autocomplete
                      class="pt-0"
                      v-if="
                        [
                          'SelectTextMult',
                          'SelectI32Mult',
                          'SelectU32Mult',
                          'SelectI64Mult',
                          'SelectF64Mult',
                        ].includes(field.field_type)
                      "
                      clearable
                      chips
                      small-chips
                      deletable-chips
                      multiple
                      counter
                      :prepend-icon="`mdi-${getFieldIcon(field.field_type)}`"
                      :items="field.options"
                      item-text="title"
                      item-value="value"
                      v-model="fieldsData[field.name]"
                      :id="field.id"
                      :name="field.name"
                      :placeholder="field.placeholder"
                      :required="field.required"
                      :disabled="field.disabled"
                      :readonly="field.readonly"
                      :class="field.css_classes"
                      :messages="field.warning"
                      :error-messages="field.error"
                    ></v-autocomplete>

                    <!-- Selection fields
                     (dynamic)
                    -->
                    <v-autocomplete
                      class="pt-0"
                      v-if="
                        [
                          'SelectTextDyn',
                          'SelectI32Dyn',
                          'SelectU32Dyn',
                          'SelectI64Dyn',
                          'SelectF64Dyn',
                        ].includes(field.field_type)
                      "
                      clearable
                      :items="field.options"
                      item-text="title"
                      item-value="value"
                      v-model="fieldsData[field.name]"
                      :id="field.id"
                      :name="field.name"
                      :placeholder="field.placeholder"
                      :required="field.required"
                      :disabled="field.disabled"
                      :readonly="field.readonly"
                      :class="field.css_classes"
                      :messages="field.warning"
                      :error-messages="field.error"
                    >
                      <template v-slot:prepend>
                        <!-- Button - Open a dialog. -->
                        <v-btn
                          fab
                          dark
                          depressed
                          small
                          color="orange darken-2"
                          @click="dynDataDialog[field.name] = true"
                        >
                          <v-icon>mdi-plus-minus-variant</v-icon>
                        </v-btn>
                      </template>
                    </v-autocomplete>

                    <!-- Selection fields
                     (multiple, dynamic)
                    -->
                    <v-autocomplete
                      class="pt-0"
                      v-if="
                        [
                          'SelectTextMultDyn',
                          'SelectI32MultDyn',
                          'SelectU32MultDyn',
                          'SelectI64MultDyn',
                          'SelectF64MultDyn',
                        ].includes(field.field_type)
                      "
                      clearable
                      chips
                      small-chips
                      deletable-chips
                      multiple
                      counter
                      :items="field.options"
                      item-text="title"
                      item-value="value"
                      v-model="fieldsData[field.name]"
                      :id="field.id"
                      :name="field.name"
                      :placeholder="field.placeholder"
                      :required="field.required"
                      :disabled="field.disabled"
                      :readonly="field.readonly"
                      :class="field.css_classes"
                      :messages="field.warning"
                      :error-messages="field.error"
                    >
                      <template v-slot:prepend>
                        <!-- Button - Open a dialog. -->
                        <v-btn
                          fab
                          dark
                          depressed
                          small
                          color="orange darken-2"
                          @click="dynDataDialog[field.name] = true"
                        >
                          <v-icon>mdi-plus-minus-variant</v-icon>
                        </v-btn>
                      </template>
                    </v-autocomplete>
                  </v-card-text>
                </v-card>
              </div>
            </div>
          </template>
        </form>
      </v-card-text>
      <!-- Form control buttons. -->
      <v-card-actions class="pt-8 px-4 pb-4">
        <!-- Delete button. -->
        <v-tooltip top>
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              fab
              dark
              small
              depressed
              color="red darken-2"
              :disabled="$route.params.indexDoc === 'new'"
              v-bind="attrs"
              v-on="on"
              @click="dialogDocDelete = true"
            >
              <v-icon>mdi-delete</v-icon>
            </v-btn>
          </template>
          <span v-text="$t('message.13')"></span>
        </v-tooltip>
        <v-spacer></v-spacer>
        <!-- Save button and create a new document. -->
        <v-tooltip top>
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              dark
              rounded
              depressed
              color="green darken-2"
              v-bind="attrs"
              v-on="on"
              @click="saveDoc('save_and_new')"
            >
              <v-icon small>mdi-content-save</v-icon>
              <v-icon small>mdi-ampersand</v-icon>
              <v-icon small>mdi-file-outline</v-icon>
            </v-btn>
          </template>
          <span v-text="$t('message.14')"></span>
        </v-tooltip>
        <!-- Save button and continue editing the document. -->
        <v-tooltip top v-if="isCreatedDoc()">
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              dark
              rounded
              depressed
              color="btnOrange.bg"
              class="orange darken-2 mx-4"
              v-bind="attrs"
              v-on="on"
              @click="saveDoc('save_and_edit')"
            >
              <v-icon small>mdi-content-save</v-icon>
              <v-icon small>mdi-ampersand</v-icon>
              <v-icon small>mdi-file-document-edit-outline</v-icon>
            </v-btn>
          </template>
          <span v-text="$t('message.15')"></span>
        </v-tooltip>
        <!-- Save button. -->
        <v-tooltip top>
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              fab
              dark
              small
              depressed
              color="blue darken-2"
              v-bind="attrs"
              v-on="on"
              @click="saveDoc()"
              :class="isCreatedDoc() ? '' : 'ml-4'"
            >
              <v-icon>mdi-content-save</v-icon>
            </v-btn>
          </template>
          <span v-text="$t('message.16')"></span>
        </v-tooltip>
      </v-card-actions>
    </v-card>

    <!-- Confirm deletion of the document. -->
    <v-dialog v-model="dialogDocDelete" max-width="290">
      <v-card>
        <v-card-title class="h6">{{ $t("message.39") }}</v-card-title>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn text color="primary" @click="dialogDocDelete = false">{{
            $t("message.18")
          }}</v-btn>
          <v-btn
            text
            color="red"
            @click="[deleteDoc(), (dialogDocDelete = false)]"
            >{{ $t("message.21") }}</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import { mapState, mapMutations, mapActions } from "vuex";
import Password from "vue-password-strength-meter";

export default {
  name: "DocumentForm",

  components: { Password },

  data: () => ({
    docTitle: "...",
    breadcrumbs: "... > ... > ...",
    vMenu: {},
    fieldsData: {},
    fields: [],
    dynDataDialog: {},
    delDynDataValue: null,
    addDynDataElem: { title: null, value: null },
    showLocalDate: {},
    maxTotalFormSize: 16384, // 16384 = ~16 Kb (default data size for the form),
    render: true,
    dialogDocDelete: false,
    is_password: false,
    // Update password.
    dialogUpdatePassword: false,
    dataUpdatePassword: {
      passwordOld: null,
      passwordNew: null,
      passwordRepeat: null,
      formHasErrors: false,
      see_pass: false,
      generate: false,
    },
    // Options password.
    optionPass: {
      passLength: 16,
      uppercaseMinCount: 3,
      lowercaseMinCount: 3,
      numberMinCount: 2,
      specialMinCount: 2,
      UPPERCASE_RE: /([A-Z])/g,
      LOWERCASE_RE: /([a-z])/g,
      NUMBER_RE: /([\d])/g,
      SPECIAL_CHAR_RE: /([@#$%^&+=*!~)(])/g,
      NON_REPEATING_CHAR_RE: /([@#$%^&+=*!~)(a-z\d])\1{2,}/gi,
    },
  }),

  computed: {
    ...mapState([
      "serviceList",
      "btnRed",
      "btnPurple",
      "btnLightBlue",
      "btnGreen",
      "btnYellow",
      "btnOrange",
      "btnDeepOrange",
    ]),
    ...mapState("documentList", [
      "documents",
      "currentPageNumber",
      "pageCount",
      "docsPerPage",
      "sortDocList",
      "sortDirectDocList",
    ]),
    ...mapState("ckeditor", ["classicCKEditor", "configCKEditor"]),
    ...mapState("colorPicker", ["swatches"]),
    valuePasswordStrength: function () {
      if (this.dataUpdatePassword.passwordNew) {
        return this.dataUpdatePassword.passwordNew;
      } else {
        return "";
      }
    },
  },

  methods: {
    ...mapMutations(["setIsAuthenticated"]),
    ...mapMutations("popUpMsgs", ["setShowMsg"]),
    ...mapMutations("documentList", [
      "setDocuments",
      "setCurrentPageNumber",
      "setDocsPerPage",
      "setSortDocList",
      "setSortDirectDocList",
      "setDataFilters",
      "setSelectDataFilters",
    ]),
    ...mapActions("documentList", ["ajaxGetDocumentList"]),
    ...mapActions("popUpMsgs", ["runShowMsg"]),
    ...mapActions("pageLockout", ["runShowOverlayPageLockout"]),
    // Router - Go back one step.
    goBack() {
      const service = this.$route.params.service;
      const collection = this.$route.params.collection;
      const indexService = this.$route.params.indexService;
      const indexCollection = this.$route.params.indexCollection;
      this.setShowMsg(false);
      this.setDocuments([]);
      this.$router.replace({
        path: `/${service}/${indexService}/${collection}/${indexCollection}/document-list`,
        query: {
          per: this.docsPerPage,
          page: this.currentPageNumber,
          sort: this.sortDocList,
          direct: this.sortDirectDocList,
        },
      });
    },
    // To Rerender Component.
    reload() {
      this.render = false;
      this.$nextTick(() => {
        this.render = true;
      });
    },
    // Check password quality.
    isStrongEnough(password) {
      const uc = password.match(this.optionPass.UPPERCASE_RE);
      const lc = password.match(this.optionPass.LOWERCASE_RE);
      const n = password.match(this.optionPass.NUMBER_RE);
      const sc = password.match(this.optionPass.SPECIAL_CHAR_RE);
      const nr = password.match(this.optionPass.NON_REPEATING_CHAR_RE);
      return (
        password.length >= this.optionPass.passLength &&
        !nr &&
        uc &&
        uc.length >= this.optionPass.uppercaseMinCount &&
        lc &&
        lc.length >= this.optionPass.lowercaseMinCount &&
        n &&
        n.length >= this.optionPass.numberMinCount &&
        sc &&
        sc.length >= this.optionPass.specialMinCount
      );
    },
    // Generate password.
    generatePassword() {
      const length = this.optionPass.passLength;
      const uppers = "QWERTYUIOPASDFGHJKLZXCVBNM";
      const lowers = "qwertyuiopasdfghjklzxcvbnm";
      const numbers = "0123456789";
      const symbols = "@#$%^&+=*!~)(";
      const charset = uppers + lowers + numbers + symbols;
      let password = "";
      for (let idx = 0, n = charset.length; idx < length; ++idx) {
        password += charset.charAt(Math.floor(Math.random() * n));
      }
      return password;
    },
    customPassword() {
      this.dataUpdatePassword.generate = true;
      //
      let password = "";
      //
      while (!this.isStrongEnough(password)) {
        password = this.generatePassword();
      }
      this.dataUpdatePassword.passwordNew = password;
      this.dataUpdatePassword.passwordRepeat = password;
      setTimeout(() => {
        this.dataUpdatePassword.generate = false;
        return undefined;
      }, 300);
    },
    // Copy Password to Clipboard.
    copyPassword() {
      let copyText = document.getElementById("newPassword");
      copyText.select();
      copyText.setSelectionRange(0, 99999); /* For mobile devices */
      navigator.clipboard.writeText(copyText.value);
    },
    // Get id form.
    getIdForm() {
      const indexService = this.$route.params.indexService;
      const indexCollection = this.$route.params.indexCollection;
      const service = this.serviceList[indexService];
      return service.collections[indexCollection].model_key
        .split("__")[1]
        .substring(1);
    },
    // Determine if the document was previously created.
    isCreatedDoc() {
      return !isNaN(Number.parseInt(this.$route.params.indexDoc));
    },
    // Get human readable version of file size.
    humanFileSize(size) {
      let idx = Math.floor(Math.log(size) / Math.log(1024));
      return (
        (size / Math.pow(1024, idx)).toFixed(2) * 1 +
        " " +
        ["B", "kB", "MB", "GB", "TB"][idx]
      );
    },
    // Default color.
    defaultColor(fieldName) {
      if (!this.fieldsData[fieldName]) {
        this.fieldsData[fieldName] = "#00000000";
      }
    },
    // Update local date.
    updateLocalDate(fieldName) {
      this.showLocalDate[fieldName] = new Date(
        this.fieldsData[fieldName]
      ).toLocaleDateString([this.$userLang, "en"]);
    },
    // Get the associative icon for the file.
    getFileIcon(extension) {
      let result;
      switch (extension.toLowerCase()) {
        case "txt":
        case "text":
          result = { color: "blue", icon: "note-text-outline" };
          break;
        case "doc":
        case "dot":
        case "wbk":
        case "docx":
        case "docm":
        case "dotx":
        case "dotm":
        case "docb":
          result = { color: "blue", icon: "microsoft-word" };
          break;
        case "xls":
        case "xlt":
        case "xlm":
        case "xlsx":
        case "xlsm":
        case "xltx":
        case "xltm":
        case "xlsb":
        case "xla":
        case "xlam":
        case "xll":
        case "xlw":
          result = { color: "green", icon: "microsoft-excel" };
          break;
        case "ppt":
        case "pot":
        case "pps":
        case "pptx":
        case "pptm":
        case "potx":
        case "potm":
        case "ppam":
        case "ppsx":
        case "ppsm":
        case "sldx":
        case "sldm":
          result = { color: "orange", icon: "microsoft-powerpoint" };
          break;
        case "accdb":
        case "accde":
        case "accdt":
        case "accdr":
          result = { color: "pink", icon: "microsoft-access" };
          break;
        case "one":
          result = { color: "purple", icon: "microsoft-onenote" };
          break;
        case "pub":
          result = { color: "teal", icon: "alpha-p-box" };
          break;
        case "xml":
          result = { color: "blue", icon: "xml" };
          break;
        case "svg":
        case "svgz":
          result = { color: "amber", icon: "svg" };
          break;
        case "pdf":
          result = { color: "red", icon: "file-pdf-box" };
          break;
        case "html":
        case "htm":
          result = { color: "orange", icon: "language-html5" };
          break;
        case "epub":
          result = { color: "lime", icon: "book-open-page-variant-outline" };
          break;
        case "odt":
          result = { color: "blue", icon: "file-document-outline" };
          break;
        case "sxw":
        case "stw":
        case "sxg":
          result = { color: "blue-grey", icon: "file-document-outline" };
          break;
        case "sxc":
        case "stc":
          result = { color: "lime", icon: "table" };
          break;
        case "sxd":
        case "std":
          result = { color: "amber", icon: "draw" };
          break;
        case "sxi":
        case "sti":
          result = { color: "orange", icon: "monitor-dashboard" };
          break;
        case "sxm":
          result = { color: "blue-grey", icon: "math-integral-box" };
          break;
        case "djvu":
        case "djv":
          result = {
            color: "grey darken-1",
            icon: "text-box-multiple-outline",
          };
          break;
        case "csv":
          result = { color: "grey darken-1", icon: "file-delimited-outline" };
          break;
        case "tsv":
        case "tab":
          result = { color: "grey darken-1", icon: "file-table-outline" };
          break;
        default:
          result = { color: "grey darken-1", icon: "file-hidden" };
      }
      return result;
    },
    // Get icon of field.
    getFieldIcon(field_type) {
      let result = "";
      switch (field_type) {
        case "InputText":
          result = "note-text-outline";
          break;
        case "AutoSlug":
          result = "snake";
          break;
        case "InputColor":
          result = "palette-outline";
          break;
        case "InputDate":
        case "InputDateTime":
          result = "calendar";
          break;
        case "InputEmail":
          result = "email-outline";
          break;
        case "InputPassword":
          result = "lock-outline";
          break;
        case "InputPhone":
          result = "phone";
          break;
        case "InputUrl":
          result = "wan";
          break;
        case "InputFile":
          result = "paperclip";
          break;
        case "InputImage":
          result = "camera-outline";
          break;
        case "InputIP":
        case "InputIPv4":
        case "InputIPv6":
          result = "account-network";
          break;
        case "TextArea":
          result = "script-text-outline";
          break;
        default:
          if (field_type.includes("Number")) {
            result = "numeric";
          } else if (field_type.includes("Range")) {
            result = "arrow-split-vertical";
          } else if (field_type.includes("Select")) {
            result = "form-select";
          }
      }
      //
      return result;
    },
    // Show popup warning.
    showWarning(msg) {
      if (msg.length > 0) {
        this.runShowMsg({ text: msg, status: "warning" });
      }
    },
    // Get data for fields of form.
    getFormData(document) {
      const vMenu = {};
      const fieldsData = {};
      const dynDataDialog = {};

      document.forEach((field) => {
        let tmp;
        if (!this.is_password) {
          this.is_password = field.name === "password";
        }
        field.error = field.error.replace(/<br>/g, " ");

        switch (field.field_type) {
          case "HiddenHash":
            fieldsData[field.name] = field.value;
            this.showWarning(field.alert);
            break;
          case "InputText":
          case "InputEmail":
          case "InputPassword":
          case "InputPhone":
          case "InputUrl":
          case "InputIP":
          case "InputIPv4":
          case "InputIPv6":
          case "AutoSlug":
          case "NumberI32":
          case "NumberU32":
          case "NumberI64":
          case "NumberF64":
          case "RangeI32":
          case "RangeU32":
          case "RangeI64":
          case "RangeF64":
          case "TextArea":
            fieldsData[field.name] = field.value;
            break;
          case "InputColor":
            vMenu[field.name] = false;
            fieldsData[field.name] = field.value || "#00000000";
            break;
          case "InputDate":
            vMenu[field.name] = false;
            field.min = field.min || "";
            field.max = field.max || "";
            fieldsData[field.name] = field.value;
            this.showLocalDate[field.name] = field.value
              ? new Date(field.value).toLocaleDateString([this.$userLang, "en"])
              : "";
            break;
          case "InputDateTime":
          case "HiddenDateTime":
            vMenu[field.name] = false;
            vMenu[`${field.name}__time`] = false;
            if (
              this.$route.params.indexDoc === "new" &&
              (field.name === "created_at" || field.name === "updated_at")
            ) {
              field.is_hide = true;
            }
            switch (field.name) {
              case "created_at":
                field.label = this.$t("message.72");
                break;
              case "updated_at":
                field.label = this.$t("message.73");
                break;
            }
            field.min = field.min || "";
            field.max = field.max || "";
            tmp = field.value || "";
            fieldsData[field.name] = tmp.length > 0 ? tmp.substr(0, 10) : null;
            fieldsData[`${field.name}__time`] =
              tmp.length > 0
                ? new Date(tmp + "Z").toLocaleTimeString().slice(0, 8)
                : new Date().toLocaleTimeString().slice(0, 5);
            this.showLocalDate[field.name] = field.value
              ? new Date(field.value).toLocaleDateString([this.$userLang, "en"])
              : "";
            break;
          case "RadioText":
          case "RadioI32":
          case "RadioU32":
          case "RadioI64":
          case "RadioF64":
          case "SelectText":
          case "SelectI32":
          case "SelectU32":
          case "SelectI64":
          case "SelectF64":
          case "SelectTextMult":
          case "SelectI32Mult":
          case "SelectU32Mult":
          case "SelectI64Mult":
          case "SelectF64Mult":
            fieldsData[field.name] = field.value;
            field.options = field.options.map(function (item) {
              return { value: item[0], title: item[1] };
            });
            break;
          case "CheckBox":
            fieldsData[field.name] = field.checked;
            break;
          case "SelectTextDyn":
          case "SelectI32Dyn":
          case "SelectU32Dyn":
          case "SelectI64Dyn":
          case "SelectF64Dyn":
          case "SelectTextMultDyn":
          case "SelectI32MultDyn":
          case "SelectU32MultDyn":
          case "SelectI64MultDyn":
          case "SelectF64MultDyn":
            fieldsData[field.name] = field.value;
            field.options = field.options.map(function (item) {
              return { value: item[0], title: item[1] };
            });
            dynDataDialog[field.name] = false;
            break;
          case "InputFile":
          case "InputImage":
            if (field.value !== null) {
              field.value.is_delete = false;
              fieldsData[field.name] = field.value;
            } else {
              fieldsData[field.name] = {
                url: "",
                is_delete: false,
              };
            }
            break;
        }
      });

      this.vMenu = vMenu;
      this.fieldsData = fieldsData;
      this.dynDataDialog = dynDataDialog;
      this.fields = document;
    },

    // Converte File to base64.
    toBase64(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = () => {
          let encoded = reader.result.toString().replace(/^data:(.*,)?/, "");
          if (encoded.length % 4 > 0) {
            encoded += "=".repeat(4 - (encoded.length % 4));
          }
          resolve(encoded);
        };
        reader.onerror = (error) => reject(error);
      });
    },

    // Save/Update the document.
    saveDoc(mode = "save") {
      this.setShowMsg(false);
      this.runShowOverlayPageLockout(true);

      const indexService = this.$route.params.indexService;
      const indexCollection = this.$route.params.indexCollection;
      const service = this.serviceList[indexService];
      const modelKey = service.collections[indexCollection].model_key;
      const cloneFieldsData = JSON.parse(JSON.stringify(this.fieldsData));

      const prepareData = () => {
        return new Promise((resolve, reject) => {
          const countFileType = this.fields.reduce((sum, field) => {
            if (field.input_type === "file") {
              ++sum;
            }
            return sum;
          }, 0);
          let dataSumSize = 0;
          const response = (counter) => {
            if (counter === countFileType) {
              if (dataSumSize <= this.maxTotalFormSize) {
                resolve();
              } else {
                const msg = `The total size of the form data exceeds the ${this.humanFileSize(
                  this.maxTotalFormSize
                )} limit.`;
                reject(msg);
              }
            }
          };
          let counter = 0;
          response(counter);
          this.fields.forEach((field) => {
            // Convert numeric data types.
            if (cloneFieldsData[field.name] !== null) {
              if (
                field.field_type.includes("I32") ||
                field.field_type.includes("U32") ||
                field.field_type.includes("I64")
              ) {
                if (field.field_type.includes("Mult")) {
                  cloneFieldsData[field.name] = cloneFieldsData[field.name].map(
                    (item) => Number.parseInt(item)
                  );
                } else {
                  cloneFieldsData[field.name] = Number.parseInt(
                    cloneFieldsData[field.name]
                  );
                }
              } else if (field.field_type.includes("F64")) {
                if (field.field_type.includes("Mult")) {
                  cloneFieldsData[field.name] = cloneFieldsData[field.name].map(
                    (item) => Number.parseFloat(item)
                  );
                } else {
                  cloneFieldsData[field.name] = Number.parseFloat(
                    cloneFieldsData[field.name]
                  );
                }
              }
            }
            // inputDateTime - Combining date and time.
            if (
              field.field_type === "InputDateTime" ||
              field.field_type === "HiddenDateTime"
            ) {
              if (cloneFieldsData[field.name]) {
                let localTime = cloneFieldsData[`${field.name}__time`];
                if (!localTime) {
                  localTime = new Date().toLocaleTimeString().slice(0, 8);
                }
                cloneFieldsData[field.name] = new Date(
                  cloneFieldsData[field.name] + "T" + localTime
                )
                  .toISOString()
                  .slice(0, 16);
              }
              delete cloneFieldsData[`${field.name}__time`];
            }
            // Preparing data from fields of the `file` type.
            if (field.input_type === "file") {
              const files = document.getElementById(field.id).files;
              if (files.length > 0) {
                const file = files[0];
                const fileName = file.name;
                dataSumSize += file.size;
                this.toBase64(file)
                  .then((data) => {
                    cloneFieldsData[field.name] = {
                      name: fileName,
                      base64: data,
                      is_delete:
                        this.$route.params.indexDoc === "new" ? false : true,
                    };
                    response(++counter);
                  })
                  .catch((error) => {
                    reject(error);
                  });
              } else {
                if (this.fieldsData[field.name].is_delete) {
                  cloneFieldsData[field.name] = {
                    name: "",
                    base64: "",
                    is_delete: true,
                  };
                } else {
                  cloneFieldsData[field.name] = null;
                }
                response(++counter);
              }
            }
          });
        });
      };

      prepareData()
        .then(() => {
          const options = {
            method: "POST",
            data: cloneFieldsData,
            url: `/admin/${this.maxTotalFormSize}/${modelKey}/save-document`,
          };
          this.axios(options)
            .then((response) => {
              const data = response.data;
              if (!data.is_authenticated) {
                this.runShowOverlayPageLockout(false);
                this.setIsAuthenticated(false);
              } else if (data.msg_err.length === 0) {
                const arr_doc = data.document;
                for (let idx = 0, len = arr_doc.length; idx < len; idx++) {
                  const field = arr_doc[idx];
                  if (
                    field.error.length > 0 ||
                    (field.alert !== undefined && field.alert.length > 0)
                  ) {
                    mode = "save_and_edit";
                    break;
                  }
                }
                switch (mode) {
                  case "save":
                    this.goBack();
                    break;
                  case "save_and_edit":
                    this.vMenu = {};
                    this.dynDataDialog = {};
                    this.delDynDataValue = null;
                    this.addDynDataElem = { title: null, value: null };
                    this.fieldsData = {};
                    this.fields = [];
                    this.getFormData(arr_doc);
                    this.reload();
                    break;
                  case "save_and_new":
                    if (this.$session.exists()) {
                      this.$session.set("num_page", this.currentPageNumber);
                      this.$session.set("num_per", this.docsPerPage);
                      this.$session.set("sort", this.sortDocList);
                      this.$session.set("direct", this.sortDirectDocList);
                    }
                    this.$router.replace(
                      {
                        name: "documenForm",
                        params: {
                          service: this.$route.params.service,
                          indexService: this.$route.params.indexService,
                          collection: this.$route.params.collection,
                          indexCollection: this.$route.params.indexCollection,
                          indexDoc: "new",
                        },
                      },
                      () => window.document.location.reload(),
                      () => window.document.location.reload()
                    );
                    break;
                }
                this.runShowOverlayPageLockout(false);
              } else {
                console.log(data.msg_err);
                this.runShowOverlayPageLockout(false);
                this.runShowMsg({ text: data.msg_err, status: "error" });
              }
            })
            .catch((error) => {
              console.log(error);
              this.runShowOverlayPageLockout(false);
              this.runShowMsg({ text: error, status: "error" });
            });
        })
        .catch((error) => {
          console.log(error);
          this.runShowOverlayPageLockout(false);
          this.runShowMsg({ text: error, status: "error" });
        });
    },

    // Get Title of document.
    getDocTitle() {
      const indexDoc = this.$route.params.indexDoc;
      let title = "";
      if (indexDoc !== "new") {
        const indexService = this.$route.params.indexService;
        const indexCollection = this.$route.params.indexCollection;
        const fieldName =
          this.serviceList[indexService].collections[indexCollection].fields[0]
            .field;
        title = this.documents[indexDoc][fieldName];
      } else {
        title = this.$t("message.26");
      }
      this.docTitle = title;
    },

    // Get scheme route of document.
    getBreadcrumbs() {
      const indexService = this.$route.params.indexService;
      const indexCollection = this.$route.params.indexCollection;
      const service = this.serviceList[indexService];
      this.breadcrumbs = `${service.service.title} > ${service.collections[indexCollection].title} > ${this.docTitle}`;
    },

    // Get document
    ajaxGetDoc(indexes) {
      const service = this.serviceList[indexes.indexService];
      const payload = {
        model_key: service.collections[indexes.indexCollection].model_key,
        doc_hash:
          this.documents[indexes.indexDoc] !== undefined
            ? this.documents[indexes.indexDoc].hash
            : "",
      };
      this.axios
        .post("/admin/get-document", payload)
        .then((response) => {
          const data = response.data;
          if (!data.is_authenticated) {
            this.runShowOverlayPageLockout(false);
            this.setIsAuthenticated(false);
          } else if (data.msg_err.length === 0) {
            // 16384 = ~16 Kb (default data size for the form)
            this.maxTotalFormSize =
              data.max_size > 16384 ? data.max_size - 16384 : data.max_size;
            this.getDocTitle();
            this.getBreadcrumbs();
            if (data.document.length > 0) {
              this.getFormData(data.document);
            }
            this.runShowOverlayPageLockout(false);
          } else {
            console.log(data.msg_err);
            this.runShowOverlayPageLockout(false);
            this.runShowMsg({ text: data.msg_err, status: "error" });
          }
        })
        .catch((error) => {
          console.log(error);
          this.runShowOverlayPageLockout(false);
          this.runShowMsg({ text: error, status: "error" });
        });
    },
    getDoc() {
      this.setShowMsg(false);
      this.runShowOverlayPageLockout(true);
      const indexService = this.$route.params.indexService;
      const indexCollection = this.$route.params.indexCollection;
      const indexDoc = this.$route.params.indexDoc;
      if (this.documents.length > 0) {
        this.ajaxGetDoc({ indexService, indexCollection, indexDoc });
      } else {
        this.ajaxGetDocumentList({ indexService, indexCollection })
          .then(() => {
            this.ajaxGetDoc({ indexService, indexCollection, indexDoc });
          })
          .catch((error) => {
            console.log(error);
            this.runShowOverlayPageLockout(false);
            this.runShowMsg({ text: error, status: "error" });
          });
      }
    },

    // Remove document from collection.
    deleteDoc() {
      this.setShowMsg(false);
      this.runShowOverlayPageLockout(true);
      const indexService = this.$route.params.indexService;
      const indexCollection = this.$route.params.indexCollection;
      const indexDoc = this.$route.params.indexDoc;
      const service = this.serviceList[indexService];
      const payload = {
        model_key: service.collections[indexCollection].model_key,
        doc_hash:
          this.documents[indexDoc] !== undefined
            ? this.documents[indexDoc].hash
            : "",
      };
      if (payload.doc_hash.length === 0) {
        this.runShowOverlayPageLockout(false);
        return;
      }
      this.axios
        .post("/admin/delete-document", payload)
        .then((response) => {
          const data = response.data;
          if (!data.is_authenticated) {
            this.runShowOverlayPageLockout(false);
            this.setIsAuthenticated(false);
          } else if (data.msg_err.length === 0) {
            this.runShowOverlayPageLockout(false);
            this.goBack();
          } else {
            console.log(data.msg_err);
            this.runShowOverlayPageLockout(false);
            this.runShowMsg({ text: data.msg_err, status: "error" });
          }
        })
        .catch((error) => {
          console.log(error);
          this.runShowOverlayPageLockout(false);
          this.runShowMsg({ text: error, status: "error" });
        });
    },

    // Adding and deleting dynamic elements.
    updateDynData(fieldName, isDelete) {
      this.setShowMsg(false);
      this.runShowOverlayPageLockout(true);
      const indexService = this.$route.params.indexService;
      const indexCollection = this.$route.params.indexCollection;
      const service = this.serviceList[indexService];
      const targetField = this.fields.filter(
        (item) => item.name === fieldName
      )[0];
      //
      let delValue;
      //
      if (isDelete) {
        if (targetField.field_type.includes("Text")) {
          delValue = this.delDynDataValue;
        } else if (targetField.field_type.includes("F64")) {
          delValue = Number.parseFloat(this.delDynDataValue);
          if (Number.isNaN(delValue)) {
            this.runShowMsg({
              text: this.$t("message.78"),
              status: "error",
            });
            return;
          }
        } else {
          delValue = Number.parseInt(this.delDynDataValue);
          if (Number.isNaN(delValue)) {
            this.runShowMsg({
              text: this.$t("message.78"),
              status: "error",
            });
            return;
          }
        }
      } else {
        // Check if the Title is correct.
        // -----------------------------------------------------------------------------------------
        this.addDynDataElem.title = this.addDynDataElem.title.trim();
        // Title uniqueness check.
        for (let idx = 0; idx < targetField.options.length; idx++) {
          if (targetField.options[idx].title === this.addDynDataElem.title) {
            this.runShowMsg({
              text: `${this.$t("message.23")}: ${this.$t("message.33")}`,
              status: "error",
            });
            return;
          }
        }

        // Check if the Value is correct.
        // -----------------------------------------------------------------------------------------
        if (targetField.field_type.includes("Text")) {
          this.addDynDataElem.value = this.addDynDataElem.value.trim();
          let value = this.addDynDataElem.value;
          // Check for the allowed number of characters.
          let valueLen = value.length;
          if (
            valueLen < targetField.minlength ||
            valueLen > targetField.maxlength
          ) {
            this.runShowMsg({
              text: `${this.$t("message.23")}: ${
                this.addDynDataElem.title
              }<br>${this.$t("message.24")}: ${this.$t("message.76")} ${
                targetField.minlength
              } <-> ${targetField.maxlength}`,
              status: "error",
            });
            return;
          }
        } else {
          // Check if the number is in the allowed range.
          // ---------------------------------------------------------------------------------------
          // Checking fractional values for an acceptable limit.
          if (targetField.field_type.includes("F64")) {
            this.addDynDataElem.value = Number.parseFloat(
              this.addDynDataElem.value
            );
            let value = this.addDynDataElem.value;
            if (Number.isNaN(value)) {
              this.runShowMsg({
                text: `${this.$t("message.23")}: ${
                  this.addDynDataElem.title
                }<br>${this.$t("message.24")}: ${this.$t("message.77")}.`,
                status: "error",
              });
              return;
            }
            if (value < -Number.MAX_VALUE || value > Number.MAX_VALUE) {
              this.runShowMsg({
                text: `${this.$t("message.23")}: ${
                  this.addDynDataElem.title
                }<br>${this.$t("message.24")}: ${this.$t(
                  "message.62"
                )} ${-Number.MAX_VALUE} <-> ${Number.MAX_VALUE}`,
                status: "error",
              });
              return;
            }
          } else {
            // Validate that the value is not fractional.
            let value = this.addDynDataElem.value;
            if (
              (typeof value === "string" &&
                (value.includes(".") || value.includes(","))) ||
              (typeof value === "number" && !Number.isInteger(value))
            ) {
              this.runShowMsg({
                text: `${this.$t("message.23")}: ${
                  this.addDynDataElem.title
                }<br>${this.$t("message.24")}: ${this.$t("message.35")}.`,
                status: "error",
              });
              return;
            }
            // Checking integer values for a valid limit.
            this.addDynDataElem.value = Number.parseInt(
              this.addDynDataElem.value
            );
            value = this.addDynDataElem.value;
            if (Number.isNaN(value)) {
              this.runShowMsg({
                text: `${this.$t("message.23")}: ${
                  this.addDynDataElem.title
                }<br>${this.$t("message.24")}: ${this.$t("message.77")}.`,
                status: "error",
              });
              return;
            }
            if (
              targetField.field_type.includes("U32") &&
              (value < 0 || value > 4294967295)
            ) {
              this.runShowMsg({
                text: `${this.$t("message.23")}: ${
                  this.addDynDataElem.title
                }<br>${this.$t("message.24")}: ${this.$t(
                  "message.62"
                )} 0 <-> 4_294_967_295`,
                status: "error",
              });
              return;
            } else if (
              targetField.field_type.includes("I32") &&
              (value < -2147483648 || value > 2147483647)
            ) {
              this.runShowMsg({
                text: `${this.$t("message.23")}: ${
                  this.addDynDataElem.title
                }<br>${this.$t("message.24")}: ${this.$t(
                  "message.62"
                )} -2_147_483_648 <-> 2_147_483_647`,
                status: "error",
              });
              return;
            } else if (
              targetField.field_type.includes("I64") &&
              (value < Number.MIN_SAFE_INTEGER ||
                value > Number.MAX_SAFE_INTEGER)
            ) {
              this.runShowMsg({
                text: `${this.$t("message.23")}: ${
                  this.addDynDataElem.title
                }<br>${this.$t("message.24")}: ${this.$t("message.62")} ${
                  Number.MIN_SAFE_INTEGER
                } <-> ${Number.MAX_SAFE_INTEGER}`,
                status: "error",
              });
              return;
            }
          }
        }
        // Value uniqueness check.
        for (let idx = 0; idx < targetField.options.length; idx++) {
          if (targetField.options[idx].value === this.addDynDataElem.value) {
            this.runShowMsg({
              text: `${this.$t("message.23")}: ${
                this.addDynDataElem.title
              }<br>${this.$t("message.24")}: ${this.$t("message.74")}`,
              status: "error",
            });
            return;
          }
        }
      }

      // Create a payload and send it to the server.
      let dynData = isDelete
        ? targetField.options.filter((item) => item.value == delValue)[0]
        : this.addDynDataElem;
      const dynDataJson = JSON.stringify({
        field_name: fieldName,
        value: dynData.value,
        title: dynData.title,
        is_delete: isDelete,
      });
      const payload = {
        model_key: service.collections[indexCollection].model_key,
        dyn_data: dynDataJson,
      };
      this.axios
        .post("/admin/update-dyn-data", payload)
        .then((response) => {
          const data = response.data;
          if (!data.is_authenticated) {
            this.runShowOverlayPageLockout(false);
            this.setIsAuthenticated(false);
          } else if (data.msg_err.length === 0) {
            // Apply changes to the current state.
            if (isDelete) {
              for (let idx = 0; idx < this.fields.length; idx++) {
                if (this.fields[idx].name === fieldName) {
                  if (
                    targetField.field_type.includes("Mult") &&
                    this.fieldsData[fieldName] !== null
                  ) {
                    this.fieldsData[fieldName] = this.fieldsData[
                      fieldName
                    ].filter((item) => item != delValue);
                  } else {
                    this.fieldsData[fieldName] = null;
                  }
                  //
                  this.fields[idx].options = this.fields[idx].options.filter(
                    (item) => item.value != delValue
                  );
                  break;
                }
              }
            } else {
              for (let idx = 0; idx < this.fields.length; idx++) {
                if (this.fields[idx].name === fieldName) {
                  this.fields[idx].options.push(this.addDynDataElem);
                  break;
                }
              }
            }
            this.setDataFilters([]);
            this.setSelectDataFilters({});
            this.runShowOverlayPageLockout(false);
          } else {
            console.log(data.msg_err);
            this.runShowOverlayPageLockout(false);
            this.runShowMsg({ text: data.msg_err, status: "error" });
          }
        })
        .catch((error) => {
          console.log(error);
          this.runShowOverlayPageLockout(false);
          this.runShowMsg({ text: error, status: "error" });
        })
        .then(() => {
          this.delDynDataValue = null;
          this.addDynDataElem = { title: null, value: null };
        });
    },
    // Refresh form for update password.
    updatePassResetForm() {
      this.setShowMsg(false);
      this.dataUpdatePassword.formHasErrors = false;
      const fields = ["passwordOld", "passwordNew", "passwordRepeat"];

      fields.forEach((field) => {
        this.$refs[field].reset();
      });
    },
    // Update password
    updatePassword() {
      this.setShowMsg(false);
      this.runShowOverlayPageLockout(true);
      this.dataUpdatePassword.formHasErrors = false;
      const fields = ["passwordOld", "passwordNew", "passwordRepeat"];

      fields.forEach((field) => {
        if (!this.dataUpdatePassword[field]) {
          this.dataUpdatePassword.formHasErrors = true;
          this.runShowOverlayPageLockout(false);
        }
        this.$refs[field].validate(true);
      });

      if (!this.dataUpdatePassword.formHasErrors) {
        const indexService = this.$route.params.indexService;
        const indexCollection = this.$route.params.indexCollection;
        const indexDoc = this.$route.params.indexDoc;
        const service = this.serviceList[indexService];
        const payload = {
          old_pass: this.dataUpdatePassword.passwordOld,
          new_pass: this.dataUpdatePassword.passwordNew,
          model_key: service.collections[indexCollection].model_key,
          doc_hash:
            this.documents[indexDoc] !== undefined
              ? this.documents[indexDoc].hash
              : "",
        };

        this.axios
          .post("/admin/update-password", payload)
          .then((response) => {
            const data = response.data;
            if (!data.is_authenticated) {
              this.runShowOverlayPageLockout(false);
              this.setIsAuthenticated(false);
            } else if (data.msg_err.length === 0) {
              this.dialogUpdatePassword = false;
              this.runShowOverlayPageLockout(false);
              this.runShowMsg({
                text: this.$t("message.56"),
                status: "success",
              });
            } else {
              console.log(data.msg_err);
              this.runShowOverlayPageLockout(false);
              this.runShowMsg({ text: data.msg_err, status: "error" });
            }
          })
          .catch((error) => {
            console.log(error);
            this.runShowOverlayPageLockout(false);
            this.runShowMsg({ text: error, status: "error" });
          });
      }
    },
  },

  created() {
    // Update the request parameters from the session.
    if (this.$session.exists()) {
      this.setCurrentPageNumber(this.$session.get("num_page") || 1);
      this.setDocsPerPage(this.$session.get("num_per") || 50);
      this.setSortDocList(this.$session.get("sort") || "alphabetical_links");
      this.setSortDirectDocList(this.$session.get("direct") || -1);
      this.$session.remove("num_page");
      this.$session.remove("num_per");
      this.$session.remove("sort");
      this.$session.remove("direct");
    }
    // Get document.
    this.getDoc();
  },
};
</script>

<style>
.Password.theme--dark .Password__strength-meter {
  background: #757575 !important;
  height: 2px !important;
}
.Password.theme--dark .Password__strength-meter:after,
.Password.theme--dark .Password__strength-meter:before {
  border-color: #212121 !important;
}
.Password.theme--light .Password__strength-meter {
  background: #e0e0e0 !important;
  height: 2px !important;
}
.Password.theme--light .Password__strength-meter:after,
.Password.theme--light .Password__strength-meter:before {
  border-color: #fff !important;
}
</style>
