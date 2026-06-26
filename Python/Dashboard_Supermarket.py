import streamlit as st #montar o dashboard
import pandas as pd #manipular planilha
import plotly.express as px #construir os gráficos

#Centralizando em tela cheia horizontalmente
st.set_page_config(layout="wide")

#Lendo o csv, separador = ";", casas decimais separadas por ","
df = pd.read_csv("supermarket_sales.csv", sep=";", decimal = ",")

#Transformando int64 in Datetime
df["Date"] = pd.to_datetime(df["Date"])

#Organizando por ordem crescente pela coluna Date
df=df.sort_values("Date")

#Criando coluna "YYYYMM"
df["Month"] = df["Date"].apply(lambda x: str(x.year) + "-" + str(x.month))

#sidebar lateral com segmentação (caixa de seleção)  

logo = st.sidebar.image('OIP.jpeg', width= 150)
title = st.title('Dashboard')
month = st.sidebar.selectbox("Mês", df["Month"].unique())

botao = st.sidebar._link_button(label='GitHub', url='https://github.com/angelomgr/Dataanalyst', help='', use_container_width=True, )


#Tabela filtrada pela caixa de seleção
df_filtered = df[df["Month"] == month]

#Criando containers
col1, col2 = st.columns(2)

#Mais containers
col3, col4, col5 = st.columns(3)

#Gráfico de total por dia em barras (colunas date e total)
grafico_date = px.bar(df_filtered, x = "Date", y = "Total", title = "Faturamento por dia" )
col1.plotly_chart(grafico_date, use_container_width= True)

#Gráfico de total por marca (colunas date e total)
grafico_unidade = px.pie(df_filtered, names = "Branch", values= "Total", color = "Total", title="Faturamento por Marcas")
col4.plotly_chart(grafico_unidade, use_container_width= True)



#graf3
grafico3 = px.bar(df_filtered, x="Date", y="Product line", color="City", title="Faturamento por tipo de produto", orientation="h")
col2.plotly_chart(grafico3, use_container_width= True)

#graf4 UF
city = df_filtered.groupby("City")[["Total"]].sum().reset_index()
grafico4 = px.bar(city, x="City", y="Total", title="Faturamento por Filial")
col3.plotly_chart(grafico4, use_container_width= True)

#graf5 média
mean = df_filtered.groupby("City")[["Rating"]].mean().reset_index()
grafico5 = px.bar(df_filtered, x="City", y="Rating", title="Rating médio por Filial")
col5.plotly_chart(grafico5, use_container_width= True, )

#Visualização da tabela
df_filtered
