<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\UsuarioLogin;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'nroControl' => [
                'required',
                'regex:/^T\d{2}120\d{3}$/', // Validación para el formato de Nro. Control
            ],
            'password' => [
                'required',
                'min:8',
                'regex:/^(?!\s)[A-Za-z\d@$!%*?&]+$/', // Validación para contraseña con caracteres especiales, números, mayúsculas, minúsculas, y sin espacios al inicio
            ],
        ]);

        $credentials = $request->only('nroControl', 'password');

        if (Auth::attempt(['nroControl' => $credentials['nroControl'], 'password' => $credentials['password']])) {
            $request->session()->regenerate();
            return redirect()->intended('/dashboard'); // Redirige a la ruta principal después del login
        }

        return back()->withErrors([
            'nroControl' => 'Las credenciales no coinciden con nuestros registros.',
        ]);
    }
}
