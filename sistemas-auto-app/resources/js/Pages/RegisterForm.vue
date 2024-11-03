<template>
    <div>
      <h2>TECNM Campus Sur de Guanajuato</h2>
      <form @submit.prevent="submitForm">
        <!-- Información General -->
        <div>
          <h3>Información General</h3>
          <div>
            <label for="nombre">Nombre(s)</label>
            <input type="text" id="nombre" v-model="nombre" @blur="validateField('nombre')" />
            <span v-if="errors.nombre">{{ errors.nombre }}</span>
          </div>
          <div>
            <label for="apellidoPaterno">Apellido Paterno</label>
            <input type="text" id="apellidoPaterno" v-model="apellidoPaterno" @blur="validateApellido('apellidoPaterno')" />
            <span v-if="errors.apellidoPaterno">{{ errors.apellidoPaterno }}</span>
          </div>
          <div>
            <label for="apellidoMaterno">Apellido Materno</label>
            <input type="text" id="apellidoMaterno" v-model="apellidoMaterno" @blur="validateApellido('apellidoMaterno')" />
            <span v-if="errors.apellidoMaterno">{{ errors.apellidoMaterno }}</span>
          </div>
          <div>
            <label for="fechaNacimiento">Fecha de Nac.</label>
            <input type="date" id="fechaNacimiento" v-model="fechaNacimiento" @blur="validateFechaNacimiento" />
            <span v-if="errors.fechaNacimiento">{{ errors.fechaNacimiento }}</span>
          </div>
          <div>
            <label>Tienes alguna discapacidad</label>
            <input type="radio" id="discapacidadSi" value="Sí" v-model="discapacidad" checked />
            <label for="discapacidadSi">Sí</label>
            <input type="radio" id="discapacidadNo" value="No" v-model="discapacidad" />
            <label for="discapacidadNo">No</label>
          </div>
          <div>
            <label for="tipoSangre">Tipo de Sangre</label>
            <select id="tipoSangre" v-model="tipoSangre">
              <option>O+</option>
              <option>O-</option>
              <option>A+</option>
              <option>A-</option>
              <option>B+</option>
              <option>B-</option>
              <option>AB+</option>
              <option>AB-</option>
            </select>
          </div>
        </div>

        <!-- Datos Académicos -->
        <div>
          <h3>Datos Académicos</h3>
          <div>
            <label for="carrera">Carrera</label>
            <select id="carrera" v-model="carrera">
              <option>Sistemas Aut.</option>
            </select>
          </div>
          <div>
            <label for="nroControl">Nro. de control</label>
            <input type="text" id="nroControl" v-model="nroControl" @blur="validateField('nroControl')" />
            <span v-if="errors.nroControl">{{ errors.nroControl }}</span>
          </div>
          <div>
            <label for="correo">Correo institucional</label>
            <input type="email" id="correo" v-model="correo" @blur="validateField('correo')" />
            <span v-if="errors.correo">{{ errors.correo }}</span>
          </div>
          <div>
            <label for="pswd">Contraseña</label>
            <input type="password" id="pswd" v-model="pswd" @blur="validateField('pswd')" />
            <span v-if="errors.pswd">{{ errors.pswd }}</span>
          </div>
          <div>
            <label for="confirmPswd">Confirme contraseña</label>
            <input type="password" id="confirmPswd" v-model="confirmPswd" @blur="validatePasswords" />
            <span v-if="errors.confirmPswd">{{ errors.confirmPswd }}</span>
          </div>
        </div>

        <!-- Botones de acción -->
        <button type="button" @click="cancelar">Cancelar</button>
        <button type="submit">Aceptar</button>
      </form>
    </div>
  </template>

  <script>
  export default {
    data() {
      return {
        nombre: '',
        apellidoPaterno: '',
        apellidoMaterno: '',
        fechaNacimiento: '',
        discapacidad: 'Sí',
        tipoSangre: 'O+',
        carrera: 'Sistemas Aut.',
        nroControl: '',
        correo: '',
        pswd: '',
        confirmPswd: '',
        errors: {}
      };
    },
    methods: {
      validateField(field) {
        if (!this[field]) {
          this.$set(this.errors, field, 'Este campo es obligatorio.');
        } else {
          this.$delete(this.errors, field);
        }
      },
      validateApellido(field) {
        const regex = /^[^\s\d\W]/;
        if (!regex.test(this[field])) {
          this.$set(this.errors, field, 'El apellido no puede comenzar con espacio, número o carácter especial.');
        } else {
          this.validateField(field);
        }
      },
      validateFechaNacimiento() {
        const minYear = 1950;
        const selectedYear = new Date(this.fechaNacimiento).getFullYear();
        if (selectedYear < minYear) {
          this.$set(this.errors, 'fechaNacimiento', 'La fecha no puede ser menor a 1950.');
        } else {
          this.validateField('fechaNacimiento');
        }
      },
      validatePasswords() {
        if (this.pswd !== this.confirmPswd) {
          this.$set(this.errors, 'confirmPswd', 'Las contraseñas no coinciden.');
        } else {
          this.validateField('confirmPswd');
        }
      },
      cancelar() {
        window.location.href = '/login';
      },
      submitForm() {
        if (Object.keys(this.errors).length === 0 && this.nombre && this.apellidoPaterno && this.apellidoMaterno && this.fechaNacimiento && this.nroControl && this.correo && this.pswd && this.confirmPswd) {
          // Enviar formulario al servidor
          this.$inertia.post('/registrar', {
            nombre: this.nombre,
            apellidoPaterno: this.apellidoPaterno,
            apellidoMaterno: this.apellidoMaterno,
            fechaNacimiento: this.fechaNacimiento,
            discapacidad: this.discapacidad,
            tipoSangre: this.tipoSangre,
            carrera: this.carrera,
            nroControl: this.nroControl,
            correo: this.correo,
            pswd: this.pswd
          });
        } else {
          alert('Por favor, completa todos los campos correctamente.');
        }
      }
    }
  };
  </script>
