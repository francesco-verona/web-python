from flask import Flask, request, jsonify, render_template
import psycopg2
import os

app = Flask(__name__)


@app.route('/')
def index():
    conn = psycopg2.connect("postgresql://franc:password@localhost:5432/example")
    cur = conn.cursor()
    cur.execute("SELECT * FROM guests;")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('guests.html', guests=rows)

@app.route('/add', methods=['GET','POST'])
def add():
    if request.method == 'POST':
        data = request.form
        conn = psycopg2.connect("postgresql://franc:password@localhost:5432/example")
        cur = conn.cursor()
        cur.execute("INSERT INTO guests (firstname, lastname) VALUES (%s, %s);",
                    (data['firstname'], data['lastname']))
        conn.commit()
        cur.close()
        conn.close()
        return jsonify({"status": "success"})
    else:
        return render_template('form.html')

if __name__ == "__main__":
    # Modo di sviluppo: autoreload e debug attivi
    app.run(host="0.0.0.0", port=5000, debug=True)
