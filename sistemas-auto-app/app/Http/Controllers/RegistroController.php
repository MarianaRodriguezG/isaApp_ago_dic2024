<?php
namespace App\Http\Controllers;

use App\Models\Alumno;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class RegistroController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'nombre' => 'required|string|max:45',
            'apellidoPaterno' => 'required|string|max:45|regex:/^[^\\s\\d\\W]/',
            'apellidoMaterno' => 'required|string|max:45|regex:/^[^\\s\\d\\W]/',
            'fechaNacimiento' => 'required|date|after_or_equal:1950-01-01',
            'nroControl' => 'required|string|max:9|unique:alumnos,nroControl',
            'correo' => 'required|email|max:100|unique:usuarios_login,correo',
            'pswd' => 'required|string|min:8|confirmed',
        ]);

        $alumno = new Alumno();
        $alumno->fill($request->all());
        $alumno->pswd = Hash::make($request->pswd);
        $alumno->save();

        return redirect('/login')->with('success', 'Registro exitoso.');
    }
}
?>
