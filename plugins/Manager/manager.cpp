/*
 * Copyright (C) 2023  ikozyris
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * cide is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <QDebug>
#include <QStandardPaths>
#include <QString>
#include <QVector>

#include "manager.h"
#include <stdio.h>
    // path to configuration file
    QString path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/args.conf";
    std::string config;

Manager::Manager()
{
    // convert at run time
    config = path.toStdString();
}


int Manager::overwrite()
{
    qDebug() << "start";


    // overwrite to file
    qDebug() << QString::fromStdString(config);

    std::FILE *fp = fopen(config.c_str(), "w");
    std::fprintf(fp, "%s", " ");
    std::fclose(fp);
    
    return 0;
}

int Manager::append(QString params)
{
    // convert QStrings to std strings
    std::string args = params.toStdString();

    // write to file
    FILE *fp = fopen(config.c_str(), "a");
    fputs(args.c_str(), fp);
    fclose(fp);
    qDebug() << "checkpoint 3";
    return 0;
}
