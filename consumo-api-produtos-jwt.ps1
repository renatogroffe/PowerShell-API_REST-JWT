[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# O projeto utilizado nestes testes está no GitHub:
# https://github.com/renatogroffe/ASPNETCore3.1_JWT-Identity

# A solução apresentada neste script já foi detalhada no artigo:
# https://medium.com/@renato.groffe/powershell-apis-rest-jwt-teste-descomplicado-de-uma-api-protegida-f82b36a9f44f

# Pode ser necessário configurar conceder o direito de acesso para
# execução de scripts - resolvi isto executando o comando a seguir
# com o PowerShell em modo Administrador:
# Set-ExecutionPolicy Unrestricted


$urlBase = "https://localhost:5001/api/"

$credenciais = @{
    UserID = "admin_apiprodutos"
    Password = "AdminAPIProdutos01!"
} | ConvertTo-Json

$credenciais

$retornoLogin = Invoke-RestMethod  -Uri ($urlBase + "login") -Method POST -ContentType "application/json" -Body $credenciais

$retornoLogin

if ($retornoLogin.authenticated) {

    $url_API_Produtos = ($urlBase + "produtos")

    $headers = @{
        Authorization = "Bearer " + $retornoLogin.accessToken
    }

    $headers

    $produto1 = @{
        CodigoBarras = "00001"
        Nome = "Teste Produto 01"
        Preco = 100.01
    } | ConvertTo-Json
    
    $retornoProduto = Invoke-RestMethod  -Uri $url_API_Produtos -Headers $headers -Method POST -ContentType "application/json" -Body $produto1

    $retornoProduto

    $produto2 = @{
        CodigoBarras = "00002"
        Nome = "Teste Produto 02"
        Preco = 22.2
    } | ConvertTo-Json
    
    $retornoProduto = Invoke-RestMethod  -Uri $url_API_Produtos -Headers $headers -Method POST -ContentType "application/json" -Body $produto2

    $retornoProduto

    $consultaProdutos = Invoke-RestMethod  -Uri $url_API_Produtos -Headers $headers -Method GET -ContentType "application/json"

    $consultaProdutos
}