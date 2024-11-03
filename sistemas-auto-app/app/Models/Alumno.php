<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Alumno extends Model
{
    use HasFactory;


    protected $table = 'alumnos';

    // Define la pk
    protected $primaryKey = 'nroControl';


    public $incrementing = false;

    // Tipo de clave primaria
    protected $keyType = 'string';

    // Define que se llenan en la bd
    protected $fillable = [
        'nroControl',
        'nombre',
        'apellidoPaterno',
        'apellidoMaterno',
        'fechaNacimiento',
        'carrera',
        'fotografia',
        'fechaIngreso',
        'tipoSangre',
        'discapacidad',
        'Carrera_claveCarrera',
        'Credencial_nroControl'
    ];

    // // establece relacion con carrera
    // public function carrera()
    // {
    //     return $this->belongsTo(Carrera::class, 'Carrera_claveCarrera', 'claveCarrera');
    // }

    // // relacion con credencial
    // public function credencial()
    // {
    //     return $this->belongsTo(Credencial::class, 'Credencial_nroControl', 'nroControl');
    // }
}
